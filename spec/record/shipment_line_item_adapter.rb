module Ordoro
  module Record
    class ShipmentLineItemAdapter < BaseAdapter

      def update_request_path(record)
        "/shipment/#{record.shipment_id}/line/#{record.id}"
      end
    end
  end
end
