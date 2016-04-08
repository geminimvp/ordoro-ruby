module Ordoro
  module Record
    class ProductWarehouseAdapter < BaseAdapter

      def record_path
        "/product/#{@product_sku}/warehouse/"
      end

      def save_embedded(record, parent)
        @product_sku = parent.sku
        @client = parent.client
        save(record)
      end

    end
  end
end
