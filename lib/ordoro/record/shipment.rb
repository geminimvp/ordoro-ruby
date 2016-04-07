require 'ordoro/record/base'

module Ordoro
  module Record
    class Shipment < Base
      attribute :id, Integer
      attribute :tags, Array[String]
      attribute :weight, BigDecimal
    end
  end
end
