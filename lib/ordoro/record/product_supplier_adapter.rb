module Ordoro
  module Record
    class ProductSupplierAdapter < BaseAdapter

      def record_path
        "/product/#{@product_sku}/supplier/"
      end

      def save_embedded(record, parent)
        @product_sku = parent.sku
        @client = parent.client
        save(record)
      end

    end
  end
end
