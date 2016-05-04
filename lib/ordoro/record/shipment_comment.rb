require 'ordoro/record/base'

module Ordoro
  module Record
    # Shipments can have comments on them. This is a write-only
    # record, as the Comments will come back on the Shipment in
    # a different format.
    class ShipmentComment < Base

      attribute :comment, String, writable_on: :create

      def save_embedded(parent)
        parent.client.adapter_for(self.class.demodulized_name)
          .save_embedded(self, parent)
      end

    end
  end
end
