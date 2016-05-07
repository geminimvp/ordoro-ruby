require 'ordoro/record/base'

module Ordoro
  module Record
    # Represents a shipment created from an Order
    class Shipment < Base

      attribute :audit_shipment, String, readonly: true
      attribute :comments, Array[Ordoro::Record::Comment], readonly: true
      attribute :notes_from_customer, String, readonly: true
      attribute :notify_cart_success, Boolean
      attribute :order_id, String, readonly: true
      attribute :requested_shipping_method, String
      attribute :ship_date, DateTime
      attribute :ship_to, Ordoro::Record::Address, readonly: true
      attribute :shipment_id, String
      attribute :status, String
      attribute :tags, Array[Ordoro::Record::Tag]
      attribute :tracking, String, readonly: true
      attribute :weight, BigDecimal

      def add_comment(comment_text)
        ShipmentComment.new(comment: comment_text).save_embedded(self)
      end

    end
  end
end
