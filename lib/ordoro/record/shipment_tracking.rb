require 'ordoro/record/base'

module Ordoro
  module Record
    # Tracking number decorated entry
    class NewTracking < Base

      attribute :tracking, String
      attribute :vendor, String
      attribute :shipping_method, String
      attribute :package_tracking, String
      attribute :cost, BigDecimal
      attribute :email_ship_to, Boolean
      attribute :email_bill_to, Boolean

    end

    # Shipment Tracking entry
    class ShipmentTracking < Base

      attribute :ship_date, DateTime
      attribute :notify_cart, Boolean
      attribute :shipment_id, String
      attribute :tracking, Ordoro::Record::NewTracking

      def save_embedded(parent)
        self.shipment_id = parent.shipment_id
        parent.client.adapter_for(self.class.demodulized_name)
              .save_embedded(self, parent)
      end

      # Fill the tracking attr with shipment tracking info
      def update_tracking(tracking_number, shipping_service)
        self.ship_date = Time.now
        self.tracking = new_tracking(tracking_number, shipping_service)
        self.notify_cart = true
      end

      def new_tracking(tracking_number, shipping_service)
        Ordoro::Record::NewTracking.new(tracking: tracking_number,
                                        vendor: shipping_service,
                                        cost: 0)
      end

    end
  end
end
