require 'tidylib/validation/rule'
require 'tidylib/validation/presence_validator'
require 'tidylib/validation/length_validator'

module Tidylib
  module Validation
    module DSL
      def validation_rules
        @validation_rules ||= []
      end

      def validate(&block)
        @validation_rules = generate_rules(block)
      end

      # def validate(method_name)
        # validation_rules << Rule.new(method_name)
      # end

      def generate_rules(block)
        RulesGenerator.new(block).generate
      end
    end

    class RulesGenerator
      def initialize(validation_block)
        @rules = []
        @validation_block = validation_block
      end

      def generate
        self.instance_eval(&@validation_block)
      end

      def presence_of(property_name)
        @rules << PresenceValidator.for(property_name)
      end

      def length_of(property_name, options)
        @rules << LengthValidator.for(property_name, options)
      end

      def method_missing(method_name, *args, &block)
        @rules << Proc.new { instance_eval &method_name }
      end
    end
  end
end
