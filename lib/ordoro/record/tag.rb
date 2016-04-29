require 'ordoro/record/base'

module Ordoro
  module Record
    # Tag records, used on Products and Orders
    class Tag < Base

      attribute :color, String
      attribute :text, String

    end
  end
end
