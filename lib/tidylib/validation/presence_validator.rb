module Tidylib
  module Validation
    class PresenceValidator
      def initialize(property_name)
        @property_name = property_name
      end

      def apply(obj)
        value = obj.send(@property_name)
        if value.nil? || value.empty?
          obj.errors.add @property_name, :blank
        end
      end
    end
  end
end
