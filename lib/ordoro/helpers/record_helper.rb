module Ordoro
  module Helpers
    # Helper for registering valid record types
    module RecordHelper
      # Registers a record type on the Ordoro::Client
      #
      # @example
      #  class Ordoro::Client
      #    record :Product
      #  end
      #
      # @return [undefined]
      #
      # @api private
      def record(record_type)
        define_method record_type do
          adapter_cache = "@#{record_type}_cache".to_sym
          unless instance_variable_defined?(adapter_cache)
            adapter_name  = "#{record_type}Adapter".to_sym
            adapter_klass = Ordoro::Record.const_get(adapter_name)
            adapter = adapter_klass.new(self, record_type)
            instance_variable_set(adapter_cache, adapter)
          end
          instance_variable_get(adapter_cache)
        end
      end
    end
  end
end
