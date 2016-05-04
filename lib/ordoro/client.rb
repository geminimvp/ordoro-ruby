require 'httparty'
require 'ordoro/helpers/record_helper'

module Ordoro
  # Client adapter for accessing Ordoro API
  class Client

    extend Helpers::RecordHelper
    include HTTParty
    base_uri 'https://api.ordoro.com'
    # TODO: put this under a flag / config var
    # debug_output $stderr

    record :Order
    record :OrderTag
    record :Product
    record :ProductSupplier
    record :ProductWarehouse
    record :Shipment
    record :ShipmentComment
    record :ShipmentTracking
    record :Supplier
    record :PurchaseOrder

    def initialize(username, password)
      @username = username
      @password = password
    end

    def request(verb, path, options={})
      options = default_request_options.merge(options)
      self.class.send(verb.to_sym, path, options)
    end

    def adapter_for(klass_name)
      public_send(klass_name.to_sym)
    end

    private

    def default_request_options
      { basic_auth: auth_params }
    end

    def auth_params
      {
        username: @username,
        password: @password,
      }
    end

  end
end
