module Ordoro
  module Record
    # Comments must be created as a child of a Shipment
    class ShipmentCommentAdapter < BaseAdapter

      def record_path
        "/shipment/#{@shipment_id}/comment/"
      end

      def save_embedded(record, parent)
        @shipment_id = parent.shipment_id
        @client = parent.client
        save(record)
      end

    end
  end
end
