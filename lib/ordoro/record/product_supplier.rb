require 'ordoro/record/base'

module Ordoro
  module Record
    # Supplier record included as part of a Product result
    class ProductSupplier < Base

      include Virtus.model

      attribute :supplier_sku, String
      attribute :min_order_qty, Integer
      attribute :is_default, Boolean
      attribute :supplier_price, BigDecimal

      def save_embedded(parent)
        parent_adapter.save_embedded(self, parent)
      end

      def parent_adapter
        parent.client.adapter_for(self.class.demodulized_name)
      end

    end
  end
end
