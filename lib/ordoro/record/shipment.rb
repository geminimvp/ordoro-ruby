require 'ordoro/record/base'

module Ordoro
  module Record
    # Represents a shipment created from an Order
    class Shipment < Base

      attribute :audit_shipment, String, readonly: true
      attribute :comments, Array[Ordoro::Record::Comment], readonly: true
      attribute :notes_from_customer, String, readonly: true
      attribute :notify_cart_success, Boolean, readonly: true
      attribute :order_id, String, readonly: true
      attribute :requested_shipping_method, String, readonly: true
      attribute :ship_date, DateTime, readonly: true
      attribute :ship_to, Ordoro::Record::Address, readonly: true
      attribute :shipment_id, String, readonly: true
      attribute :status, String, readonly: true
      attribute :tags, Array[Ordoro::Record::Tag], readonly: true
      attribute :tracking, String, readonly: true
      attribute :weight, BigDecimal, readonly: true
      attribute :lines, Array[Ordoro::Record::ShipmentLineItem], readonly: true
      attribute :assigned_to_id, Integer, writable_on: :update

      def initialize(attributes={})
        self.shipment_id = attributes.delete('id_token')
        super(attributes)
      end

      def persisted?
        shipment_id
      end

      def add_comment(comment_text)
        ShipmentComment.new(comment: comment_text).save_embedded(self)
      end

      def dropship(supplier_id)
        adapter = @client.adapter_for(self.class.demodulized_name)
        adapter.create_dropship(self, supplier_id)
      end

    end
  end
end
