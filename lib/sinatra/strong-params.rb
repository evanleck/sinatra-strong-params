# encoding: UTF-8
# frozen_string_literal: true
require 'sinatra/base'
require 'sinatra/strong-params/version'

class RequiredParamMissing < ArgumentError; end

module Sinatra
  module StrongParams
    def self.registered(app)
      #
      # A way to whitelist parameters.
      #
      #   get '/', allows: [:id, :action] do
      #     erb :index
      #   end
      #
      # Modifies the parameters available in the request scope.
      # Stashes unmodified params in @_params
      #
      app.set(:allows) do |*passable|
        condition do
          unless @params.empty?
            @_params = @_params || @params # for safety
            globals  = settings.globally_allowed_parameters
            passable = (globals | passable).map(&:to_sym) # make sure it's a symbol

            # Keep only the allowed parameters.
            @params = @params.delete_if do |param, _value|
              !passable.include?(param.to_sym)
            end
          end
        end
      end

      #
      # A way to require parameters
      #
      #   get '/', needs: [:id, :action] do
      #     erb :index
      #   end
      #
      # Does not modify the parameters available to the request scope.
      # Raises a RequiredParamMissing error if a needed param is missing
      #
      app.set(:needs) do |*needed|
        condition do
          if @params.nil? || @params.empty? && !needed.empty?
            fail RequiredParamMissing, settings.missing_parameter_message
          else
            needed     = needed.map(&:to_sym) # make sure it's a symbol
            sym_params = @params.dup

            # symbolize the keys so we know what we're looking at
            sym_params.keys.each do |key|
              sym_params[(key.to_sym rescue key) || key] = sym_params.delete(key)
            end

            if needed.any? { |key| sym_params[key].nil? || sym_params[key].empty? }
              fail RequiredParamMissing, settings.missing_parameter_message
            end
          end
        end
      end

      # These will always pass through the 'allows' method
      #   and will be mapped to symbols. I often use [:redirect_to, :_csrf] here
      #   because I always want them to pass through for later processing
      app.set :globally_allowed_parameters, []

      # The default message when RequiredParamMissing is raised.
      app.set :missing_parameter_message, 'One or more required parameters were missing.'

      # Change the default behavior for missing parameters by overriding this route.
      # For example...
      #
      #   error RequiredParamMissing do
      #     flash[:error] = env['sinatra.error'].message
      #     redirect back
      #   end
      #
      app.error RequiredParamMissing do
        [400, env['sinatra.error'].message]
      end
    end
  end

  register StrongParams
end
