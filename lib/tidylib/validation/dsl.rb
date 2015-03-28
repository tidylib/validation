require 'tidylib/validation/presence_validator'
require 'tidylib/validation/length_validator'

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

      def validates_presence_of(property_name)
        property_validations << PresenceValidator.new(property_name)
      end

      def validates_length_of(property_name, options)
        property_validations << LengthValidator.new(property_name, options)
      end
    end
  end
end
