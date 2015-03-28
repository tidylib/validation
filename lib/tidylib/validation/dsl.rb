require 'tidylib/validation/property_validator'

module Tidylib
  module Validation
    module DSL
      def validation_rules
        @validation_rules ||= []
      end

      def property_validations
        @property_validations ||= []
      end

      def validate(method_name)
        validation_rules << method_name
      end

      def validates(property, options)
        property_validations << PropertyValidator.new(property, options)
      end
    end
  end
end
