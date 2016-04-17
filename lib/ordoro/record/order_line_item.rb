require 'ordoro/record/base'

module Ordoro
  module Record
    class OrderLineItem < Base
      attribute :_link, String
      attribute :cart_orderitem_id, Integer
      attribute :product, Ordoro::Record::Product
      attribute :item_price, BigDecimal
      attribute :manually_edited, Boolean, readonly: true
      attribute :option_price, BigDecimal
      attribute :order_line_id, Integer
      attribute :product_name, String
      attribute :quantity, Integer
      attribute :selected_option, String
      attribute :shippability, String
      attribute :tax_lines, Array[Ordoro::Record::TaxLineItem]
      attribute :total_price, BigDecimal

      # The product record that arrives as part of the OrderLineItem is
      # abbreviated, so sometimes we need the full record (e.g. with
      # warehouse data).
      def full_product
        client.Product.find(product.sku)
      end

    end
  end
end
