require 'ordoro/record/base'

module Ordoro
  module Record
    class Order < Base

      attribute :_link, String, readonly: true
      attribute :billing_address, Ordoro::Record::Address
      attribute :cart, Integer
      attribute :cart_name, String
      attribute :cart_order_id, String
      attribute :cart_shipment_id, String
      attribute :comments, Array[Ordoro::Record::Comment]
      attribute :company_id, Integer
      attribute :credit_card_issuer, String
      attribute :discount_amount, BigDecimal
      attribute :grand_total, BigDecimal
      attribute :lines, Array[Ordoro::Record::OrderLineItem]
      attribute :manually_edited, Boolean, readonly: true
      attribute :notes_from_customer, String
      attribute :order_date, DateTime
      attribute :order_id, String
      attribute :product_amount, BigDecimal
      attribute :shipments, Array[Ordoro::Record::Shipment]
      attribute :shippability, String, readonly: true
      attribute :shipping_address, Address
      attribute :shipping_amount, BigDecimal
      attribute :shipping_type, String
      attribute :status, String, readonly: true
      attribute :tags, Array[Ordoro::Record::Tag]
      attribute :tax_amount, BigDecimal
      attribute :tax_lines, Array[Ordoro::Record::TaxLineItem]
      attribute :total_price, BigDecimal

      def id
        order_id
      end

    end
  end
end
