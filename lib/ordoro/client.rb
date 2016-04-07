require 'httparty'
require 'ordoro/helpers/record_helper'

module Ordoro
  class Client
    extend Helpers::RecordHelper
    include HTTParty
    base_uri 'https://api.ordoro.com'
    debug_output $stderr

    record :Order
    record :Product

    def initialize(username, password, options={})
      @username = username
      @password = password
    end

    def request(verb, path, options={})
      options = default_request_options.merge(options)
      $stderr.puts "Client#request: for #{verb} to #{path} with #{options.inspect}"
      self.class.send(verb.to_sym, path, options)
    end

    def adapter_for(klass_name)
      self.public_send(klass_name.to_sym)
    end

    private

    def default_request_options
      {
        basic_auth: auth_params
      }
    end

    def auth_params
      {
        username: @username,
        password: @password
      }
    end

  end
end
