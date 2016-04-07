require 'ordoro/record/base'

module Ordoro
  module Record
    class Comment < Base
      attribute :date, DateTime, readonly: true
      attribute :text, String
      attribute :user, String
    end
  end
end
