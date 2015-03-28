module Tidylib
  module Validation
    class PresenceValidator
      attr_reader :property_name

      def initialize(property_name)
        @property_name = property_name
      end

      def error_for(value)
        if value.nil? || value.empty?
          [@property_name, :blank]
        end
      end
    end
  end
end
