module Ordoro
  module Record
    class OrderTagAdapter < BaseAdapter

      def json_root
        "tag"
      end

      def record_path
        "/#{json_root}/order/"
      end

    end
  end
end
