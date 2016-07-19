module Ordoro
  module Record
    class ShipmentLineItemAdapter < BaseAdapter

      def record_path
        "/shipment/#{@shipment_id}/line/"
      end

      def save_embedded(record, parent)
        @shipment_id = parent.shipment_id
        @client = parent.client
        save(record)
      end

    end
  end
end
