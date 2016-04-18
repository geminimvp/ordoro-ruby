require 'ordoro/record/base'

module Ordoro
  module Record
    class Supplier < Base

      attribute :address, Ordoro::Record::Address
      attribute :company, String
      attribute :email, String

    end
  end
end
