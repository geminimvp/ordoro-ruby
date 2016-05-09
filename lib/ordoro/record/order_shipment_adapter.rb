module Ordoro
  module Record
    class OrderShipmentAdapter < BaseAdapter

      def record_path
        "/order/#{@order_id}/create_shipment/"
      end

      def save_embedded(record, parent)
        @order_id = parent.order_id
        @client = parent.client
        save(record)
      end

    end
  end
end
