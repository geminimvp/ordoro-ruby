require 'ordoro/record/base'

module Ordoro
  module Record
    class TaxLineItem < Base
      attribute :amount, BigDecimal
      attribute :name, String
      attribute :rate, Float
    end
  end
end
