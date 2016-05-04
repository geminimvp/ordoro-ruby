require 'ordoro/record/base'

module Ordoro
  module Record
    # When reading a record, Comments come through as JSON objects
    class Comment < Base

      attribute :date, DateTime, readonly: true
      attribute :text, String
      attribute :user, String

    end
  end
end
