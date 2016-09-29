module Ordoro
  module Record
    class PurchaseOrderAdapter < BaseAdapter

      def update_request_path(record)
        "#{record_path}#{record.po_id}/"
      end

      def send_to_supplier_path(record)
        "#{record_path}#{record.sku}/send/"
      end

      def send_to_supplier(record)
        request_path = send_to_supplier_path(record)
        request_body = {}
        request_params = {
          body: request_body.as_json,
          raise_errors: false,
        }
        response = request(:get, request_path, request_params)
        handle_response(record, response)
      end

    end
  end
end
