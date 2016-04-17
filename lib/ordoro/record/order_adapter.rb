module Ordoro
  module Record
    class OrderAdapter < BaseAdapter

      def update_request_path(record)
        "#{record_path}#{record.order_id}/"
      end

    end
  end
end
