require 'ordoro/record/base'

module Ordoro
  module Record
    class Order < Base

      attribute :_link, String, readonly: true
      attribute :billing_address, Ordoro::Record::Address, readonly: true
      attribute :cart, Integer, readonly: true
      attribute :cart_name, String, readonly: true
      attribute :cart_order_id, String
      attribute :cart_shipment_id, String
      attribute :comments, Array[Ordoro::Record::Comment], readonly: true
      attribute :company_id, Integer, readonly: true
      attribute :credit_card_issuer, String
      attribute :discount_amount, BigDecimal
      attribute :grand_total, BigDecimal
      attribute :lines, Array[Ordoro::Record::OrderLineItem], readonly: true
      attribute :manually_edited, Boolean, readonly: true
      attribute :notes_from_customer, String
      attribute :order_date, DateTime
      attribute :order_id, String, readonly: true
      attribute :product_amount, BigDecimal
      attribute :shipments, Array[Ordoro::Record::Shipment], readonly: true
      attribute :shippability, String, readonly: true
      attribute :shipping_address, Address, readonly: true
      attribute :shipping_amount, BigDecimal
      attribute :shipping_type, String
      attribute :status, String, readonly: true
      attribute :tag_ids, Array[Integer]
      attribute :tags, Array[Ordoro::Record::Tag], readonly: true
      attribute :tax_amount, BigDecimal
      attribute :tax_lines, Array[Ordoro::Record::TaxLineItem], readonly: true
      attribute :total_price, BigDecimal, readonly: true

      def initialize(attributes={})
        self.order_id = attributes.delete('id_token')
        super(attributes)
      end

      def persisted?
        order_id
      end

    end
  end
end
