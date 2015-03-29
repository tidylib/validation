require 'tidylib/validation/rule'
require 'tidylib/validation/presence_validator'
require 'tidylib/validation/length_validator'

module Tidylib
  module Validation
    module DSL
      def validation_rules
        @validation_rules ||= []
      end

      def validate(method_name)
        validation_rules << Rule.new(method_name)
      end

      def validates_presence_of(property_name)
        validation_rules << PresenceValidator.new(property_name)
      end

      def validates_length_of(property_name, options)
        validation_rules << LengthValidator.new(property_name, options)
      end
    end
  end
end
