require 'tidylib/validation/property_validator'

module Tidylib
  module Validation
    module DSL
      def custom_validations
        @custom_validations ||= []
      end

      def property_validations
        @property_validations ||= []
      end

      def validate(method_name)
        custom_validations << method_name
      end

      def validates(property, options)
        property_validations << PropertyValidator.new(property, options)
      end
    end
  end
end
