module Tidylib
  module Validation
    class Rule
      def initialize(method_name)
        @method_name = method_name
      end

      def apply(obj)
        obj.instance_eval(&@method_name)
      end
    end
  end
end
