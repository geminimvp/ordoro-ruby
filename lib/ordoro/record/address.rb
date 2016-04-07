require 'ordoro/record/base'

module Ordoro
  module Record
    class Address < Base
      attribute :_link, String
      attribute :cart_address_id, Integer
      attribute :reference_number, String
      attribute :name, String
      attribute :company, String
      attribute :email, String
      attribute :street1, String
      attribute :street2, String
      attribute :city, String
      attribute :state, String
      attribute :zip, String
      attribute :country_code, String
      attribute :is_commercial, Boolean
      attribute :phone, String
      attribute :fax, String
    end
  end
end
