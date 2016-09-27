require 'ordoro/record/base'

module Ordoro
  module Record
    class PurchaseOrder < Base

      attribute :status, String, readonly: true
      attribute :shipping_method, String
      attribute :items, Array[Ordoro::Record::PurchaseOrderLineItem], readonly: true
      attribute :po_id, String, writable_on: :create
      attribute :company_id, Integer, readonly: true
      attribute :warehouse, Integer
      attribute :supplier, Ordoro::Record::Supplier, readonly: true
      attribute :sent, DateTime
      attribute :instructions, String

      def initialize(attributes={})
        self.po_id = attributes.delete('id_token')
        super(attributes)
      end

      def persisted?
        po_id
      end
    end
  end
end
