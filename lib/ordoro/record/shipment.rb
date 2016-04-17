require 'ordoro/record/base'

module Ordoro
  module Record
    class Shipment < Base
      attribute :tags, Array[Ordoro::Record::Tag]
      attribute :weight, BigDecimal
    end
  end
end
