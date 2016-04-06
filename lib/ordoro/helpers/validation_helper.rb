module Ordoro
  module Helpers
    module ValidationHelper

      def valid?
        errors.empty?
      end

      def errors
        @errors ||= Ordoro::Errors.new(self)
      end
    end
  end

  class Errors
    attr_reader :messages

    def initialize(base)
      @base = base
      @messages = {}
    end

    def [](attribute)
      messages[attribute.to_sym]
    end

    def clear
      @messages.clear
    end

    def empty?
      messages.all? {|k, v| v && v.empty? && !v.is_a?(String) }
    end

    def from_response(error_hash)
      error_hash.each do |attr, errors| 
        @messages[attr.to_sym] = errors
      end
    end
  end

end
