require 'ordoro/record/base'

module Ordoro
  module Record
    # A shipment created from an Order
    class OrderShipment < Base

      def save_embedded(parent)
        parent.client.adapter_for(self.class.demodulized_name)
              .save_embedded(self, parent)
      end

    end
  end
end
