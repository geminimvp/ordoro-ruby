module Ordoro
  module Record
    class PurchaseOrderAdapter < BaseAdapter

      def update_request_path(record)
        "#{record_path}#{record.po_id}/"
      end

    end
  end
end
