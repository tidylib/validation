module Tidylib
  module Validation
    class PresenceValidator
      def self.for(property_name)
        Proc.new do
          value = send(property_name)
          if value.nil? || value.empty
            errors.add property_name, :blank
          end
        end
      end
    end
  end
end
