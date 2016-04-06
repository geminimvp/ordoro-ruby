require 'ordoro/record/base'

module Ordoro
  module Record
    class Order < Base

      def with_new_status
        request_path = "/order/?status=new"
        response = @client.http_get(request_path)
      end

    end
  end
end
