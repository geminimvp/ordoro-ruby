require 'ordoro/record/base'

module Ordoro
  module Record
    class Supplier < Base

      attribute :name, String
      attribute :company, String
      attribute :street1, String
      attribute :street2, String
      attribute :city, String
      attribute :state, String
      attribute :zip, String
      attribute :country, String
      attribute :reference_number, String
      attribute :email, String
      attribute :phone, String
      attribute :fax, String
      attribute :cart_address_id, String

    end
  end
end
