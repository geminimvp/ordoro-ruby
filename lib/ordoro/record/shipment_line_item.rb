require 'ordoro/record/base'

module Ordoro
  module Record
    class ShipmentLineItem < Base
      attribute :_link, String, readonly: true
      attribute :cart_orderitem_id, Integer, readonly: true
      attribute :shipment_id, Integer, readonly: true
      attribute :comment, String
      attribute :product, Ordoro::Record::Product, readonly: true
      attribute :item_price, BigDecimal, readonly: true
      attribute :total_price, BigDecimal, readonly: true
      attribute :cogs, BigDecimal, readonly: true
      attribute :manually_edited, Boolean, readonly: true
      attribute :option_price, BigDecimal, readonly: true
      attribute :order_line_id, Integer, readonly: true
      attribute :product_name, String, readonly: true
      attribute :ordered_quantity, Integer, readonly: true
      attribute :quantity, Integer
      attribute :selected_option, String, readonly: true
      attribute :shippability, String, readonly: true
      attribute :tax_lines, Array[Ordoro::Record::TaxLineItem], readonly: true
      attribute :total_price, BigDecimal, readonly: true

      # The product record that arrives as part of the OrderLineItem is
      # abbreviated, so sometimes we need the full record (e.g. with
      # warehouse data).
      def full_product
        client.Product.find(product.sku)
      end

    end
  end
end
