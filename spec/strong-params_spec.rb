# encoding: UTF-8
# frozen_string_literal: true
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require_relative 'spec_helper'
require 'json'
require 'sinatra/strong-params'

describe Sinatra::StrongParams do
  context "using allows filter" do
    context "with no nested params" do
      let(:request_params) { { id: 'id', action: 'action', not_allows: 'not_allows' } }

      it 'supports accessing params with string keys' do
        actual_params = nil
        mock_app do
          register Sinatra::StrongParams
          get '/', allows: [:id, :action] { actual_params = params }
        end

        get '/', request_params
        expect(actual_params['id']).to eq request_params[:id]
        expect(actual_params['action']).to eq request_params[:action]
        expect(actual_params['not_allows']).to eq nil
      end

      it 'supports accessing params with symbol keys' do
        actual_params = nil
        mock_app do
          register Sinatra::StrongParams
          get '/', allows: [:id, :action] { actual_params = params }
        end

        get '/', request_params
        expect(actual_params[:id]).to eq request_params[:id]
        expect(actual_params[:action]).to eq request_params[:action]
        expect(actual_params[:not_allows]).to eq nil
      end
    end

    context "with nested params" do
      let(:request_params) { { id: [ { in_array: 'in_array'} ], action: { nested_hash: 'nested_hash'} }}

      it 'supports accessing params with string keys' do
        actual_params = nil
        mock_app do
          register Sinatra::StrongParams
          get '/', allows: [:id, :action] { actual_params = params }
        end

        get '/', request_params
        expect(actual_params['id'][0]['in_array']).to eq request_params[:id][0][:in_array]
        expect(actual_params['action']['nested_hash']).to eq request_params[:action][:nested_hash]
      end

      it 'supports accessing params with symbol keys' do
        actual_params = nil
        mock_app do
          register Sinatra::StrongParams
          get '/', allows: [:id, :action] { actual_params = params }
        end

        get '/', request_params
        expect(actual_params[:id][0][:in_array]).to eq request_params[:id][0][:in_array]
        expect(actual_params[:action][:nested_hash]).to eq request_params[:action][:nested_hash]
      end
    end
  end

  context "using needs filter" do
    it 'supports accessing params with string keys' do
      actual_params = nil
      mock_app do
        register Sinatra::StrongParams
        get '/', needs: [:id, :action] { actual_params = params }
      end
      params = { id: 'id', action: 'action' }

      get '/', params
      expect(actual_params['id']).to eq params[:id]
      expect(actual_params['action']).to eq params[:action]
    end

    it 'supports accessing params with symbol keys' do
      actual_params = nil
      mock_app do
        register Sinatra::StrongParams
        get '/', needs: [:id, :action] { actual_params = params }
      end
      params = { id: 'id', action: 'action' }

      get '/', params
      expect(actual_params[:id]).to eq params[:id]
      expect(actual_params[:action]).to eq params[:action]
    end
  end
end
