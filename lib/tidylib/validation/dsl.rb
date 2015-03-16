module Tidylib
  module Validation
    module DSL
      attr_reader :validation_rules

      def validate(method_name)
        @validation_rules ||= []
        @validation_rules << method_name
      end
    end
  end
end
