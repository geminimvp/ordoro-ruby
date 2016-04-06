require 'ordoro/record/base'

module Ordoro
  module Record
    class Product < Base

      attribute :available_on_hand, Integer
      attribute :category, String
      attribute :cost, BigDecimal
      attribute :id, Integer
      attribute :low_stock_threshold, Integer
      attribute :name, String
      attribute :on_hand, Integer
      attribute :original_sku, String
      attribute :out_of_stock_threshold, Integer
      attribute :price, BigDecimal
      attribute :sku, String
      attribute :sync, Boolean
      attribute :total_on_hand, Integer
      attribute :variant_sku, String
      attribute :weight, Float

    end

  end
end
