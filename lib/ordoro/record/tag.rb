require 'ordoro/record/base'

module Ordoro
  module Record
    class Tag < Base
      include Virtus.model

      attribute :color, String
      attribute :text, String

    end
  end
end
