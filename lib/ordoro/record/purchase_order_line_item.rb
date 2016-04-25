require 'ordoro/record/base'

module Ordoro
  module Record
    class PurchaseOrderLineItem < Base

      attribute :available_on_hand, Integer
      attribute :product, Ordoro::Record::Product
      attribute :to_be_shipped, Integer
      attribute :quantity_received, Integer
      attribute :quantity, Integer

    end
  end
end
