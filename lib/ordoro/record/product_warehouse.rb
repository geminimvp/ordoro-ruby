require 'ordoro/record/base'

module Ordoro
  module Record
    # Product warehouse record, which contains warehouse inventory
    class ProductWarehouse < Base

      attribute :address, Ordoro::Record::Address, readonly: true
      attribute :always_dropship, Boolean, readonly: true
      attribute :cart, String, readonly: true
      attribute :is_configured_for_shipping, Boolean, readonly: true
      attribute :is_default_location, Boolean, readonly: true
      attribute :location_in_warehouse, String
      attribute :low_stock_threshold, Integer
      attribute :on_hand, Integer
      attribute :out_of_stock_threshold, Integer

      def save_embedded(parent)
        parent.client.adapter_for(self.class.demodulized_name)
              .save_embedded(self, parent)
      end

    end
  end
end
