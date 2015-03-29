require 'tidylib/validation/rules_generator'

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
  end
end
