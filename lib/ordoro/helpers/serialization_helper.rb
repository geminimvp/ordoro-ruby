module Ordoro
  module Helpers
    module SerializationHelper

      def as_json
        serializable_hash
      end

      def serializable_hash
        attribute_hash = {}
        attribute_set.each do |attribute|
          next unless writeable?(attribute)
          serialize_attribute(attribute_hash, attribute)
        end
        attribute_hash
      end

      def writeable?(attribute)
        return if attribute.options[:readonly]
        return true unless attribute.options[:writeable_on]
        case attribute.options[:writeable_on]
        when :update
          persisted?
        when :create
          !persisted?
        else
          raise ArgumentError
        end
      end

      def serialize_attribute(attribute_hash, attribute)
        attribute_hash[attribute.name] = _serialize(attributes[attribute.name])
      end

      def _serialize(serialized)
        if serialized.respond_to?(:serializable_hash)
          serialized.serializable_hash
        else
          case serialized
          when Array
            serialized.map {|attr| _serialize(attr) }
          when BigDecimal
            serialized.to_s("F")
          else
            serialized
          end
        end
      end

    end
  end
end
