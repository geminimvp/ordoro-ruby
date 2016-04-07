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
    end
  end
end
