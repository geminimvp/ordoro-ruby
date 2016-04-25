require 'ordoro/record/base'

module Ordoro
  module Record
    class PurchaseOrder < Base

      attribute :status
      attribute :shipping_method
      attribute :items, Array[Ordoro::Record::PurchaseOrderLineItem]
      attribute :po_id, String
      attribute :company_id, Integer
      attribute :warehouse, String
      attribute :supplier, Ordoro::Record::Supplier
      attribute :sent, DateTime
      attribute :instructions, String
    end
  end
end
