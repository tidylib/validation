require 'tidylib/validation/presence_validator'
require 'tidylib/validation/length_validator'

module Tidylib
  module Validation
    class RulesGenerator
      def initialize(validation_block)
        @rules = []
        @validation_block = validation_block
      end

      def generate
        self.instance_eval(&@validation_block)

        @rules
      end

      def presence_of(property_name)
        @rules << PresenceValidator.for(property_name)
      end

      def length_of(property_name, options)
        @rules << LengthValidator.for(property_name, options)
      end

      def method_missing(method_name, *args, &block)
        @rules << Proc.new { instance_eval(&method_name) }
      end
    end
  end
end
