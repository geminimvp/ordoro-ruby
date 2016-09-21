module Ordoro
  module Record
    class ProductAdapter < BaseAdapter

      def update_request_path(record)
        "#{record_path}#{record.sku}/"
      end

      def buy_from_supplier_path(record, supplier_id)
        "#{record_path}#{record.sku}/buy/#{supplier_id}/"
      end

      def buy_from_supplier(record, supplier_id, quantity)
        request_path = buy_from_supplier_path(record, supplier_id)
        datestamp = Time.now.strftime("%Y%m%d%H%M%S%L")
        purchase_order_id = "PO#{datestamp}"
        warehouse_id = 39366

        request_body = {
          warehouse: warehouse_id,
          po_id: purchase_order_id,
          quantity: quantity,
        }
        request_params = {
          body: request_body.as_json,
          raise_errors: false,
        }
        response = request(:post, request_path, request_params)
        handle_response(record, response)
      end

    end
  end
end
