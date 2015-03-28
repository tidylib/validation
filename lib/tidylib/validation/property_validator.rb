module Tidylib
  module Validation
    class PropertyValidator
      attr_reader :property

      def initialize(property, options)
        @property = property
        @options = options
      end

      def error_for(value)
        if value.nil? || value.empty?
          [@property, :blank]
        end
      end
    end
  end
end
