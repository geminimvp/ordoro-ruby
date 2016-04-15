module Ordoro
  module Record
    class ProductAdapter < BaseAdapter

      def update_request_path(record)
        "#{record_path}#{record.sku}/"
      end

    end
  end
end
