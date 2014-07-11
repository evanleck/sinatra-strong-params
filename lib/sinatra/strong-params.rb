require 'sinatra/base'
require 'sinatra/strong-params/version'

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
          unless @params.blank?
            @_params = @_params || @params # for safety
            globals  = settings.globally_allowed_parameters
            passable = (globals | passable).map(&:to_sym) # make sure it's a symbol

            # trim the params down
            @params = @params.select do |param, value|
              passable.include?(param.to_sym)
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
            # we're fucked, walk away
            raise RequiredParamMissing, 'One or more required parameters were missing.'
          else
            @_params   = @_params || @params # for safety
            needed     = needed.map(&:to_sym) # make sure it's a symbol
            sym_params = @params.dup

            # symbolize the keys so we know what we're looking at
            sym_params.keys.each do |key|
              sym_params[(key.to_sym rescue key) || key] = sym_params.delete(key)
            end

            if needed.any? { |key| sym_params[key].nil? || sym_params[key].empty? }
              raise RequiredParamMissing, 'One or more required parameters were missing.'
            end
          end
        end
      end

      # these will always pass through the 'allows' method
      # and will be mapped to symbols
      app.set :globally_allowed_parameters, ['redirect_to', '_csrf']

      app.error RequiredParamMissing do
        [400, 'Required parameter was missing']
      end
    end
  end

  register StrongParams
end
