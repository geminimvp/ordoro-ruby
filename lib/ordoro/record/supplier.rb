require 'ordoro/record/base'

module Ordoro
  module Record
    class Supplier < Base

      attribute :address, Ordoro::Record::Address

    end
  end
end
