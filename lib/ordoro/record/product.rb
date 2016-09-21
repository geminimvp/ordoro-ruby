require 'ordoro/record/base'

module Ordoro
  module Record
    class Product < Base

      attribute :available_on_hand, Integer, readonly: true
      attribute :category, String
      attribute :cost, BigDecimal
      attribute :low_stock_threshold, Integer
      attribute :name, String
      attribute :on_hand, Integer, readonly: true
      attribute :original_sku, String
      attribute :out_of_stock_threshold, Integer
      attribute :price, BigDecimal
      attribute :sku, String
      attribute :suppliers, Array[Ordoro::Record::ProductSupplier], readonly: true
      attribute :sync, Boolean
      attribute :total_on_hand, Integer, readonly: true
      attribute :variant_sku, String
      attribute :warehouses, Array[Ordoro::Record::ProductWarehouse], readonly: true
      attribute :weight, Float

      def initialize(attributes={})
        self.sku = attributes['id_token']
        super(attributes)
      end

      def save
        super
        save_warehouses
      end

      # The API doesn't allow us to save warehouses in the Product
      # PUT request, so we have to make separate calls for those.
      # It would probably be safer to save these individually since
      # we could introduce a race condition, but premature
      # optimization is the root of all evil.
      def save_warehouses
        warehouses.each do |product_warehouse|
          product_warehouse.save_embedded(self)
        end
      end

      def buy_from(supplier_id, quantity)
        @client.adapter_for(self.class.demodulized_name).buy_from_supplier(self, supplier_id, quantity)
      end

    end
  end
end
