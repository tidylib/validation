require 'tidylib/validation/rule'
require 'tidylib/validation/presence_validator'
require 'tidylib/validation/length_validator'

module Tidylib
  module Validation
    module DSL
      def validation_rules
        @validation_rules ||= RulesGenerator.new(@validation_block).generate
      end

      def validate(&block)
        @validation_block = block
      end
    end

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
