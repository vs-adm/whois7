# encoding: utf-8
require 'json'
require 'singleton'
require 'forwardable'
require 'faraday'
require 'faraday_middleware'

module Whois7
  module Api
    class Client
      extend SingleForwardable
      include Singleton

      single_delegate [:fqdn_get] => :instance

      def fqdn_get(fqdn)
        response = connection.get do |r|
          r.params[:q] = fqdn
        end

        unless response.status == 200
          raise "Response code is #{response.status} instead of 200 requesting #{fqdn}"
        end

        response.body
      end

      private

      def connection
        @connection ||= Faraday.new(url: api_endpoint) do |conn|
          conn.response :json, :content_type => /\bplain$/
          conn.adapter Faraday.default_adapter
        end
      end

      def api_endpoint
        "http://api.whois7.ru/"
      end
    end
  end
end
