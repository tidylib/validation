module Tidylib
  module Validation
    class LengthValidator
      attr_reader :property_name

      def initialize(property_name, options)
        @property_name = property_name
        @options = options
        @minimum = @options[:minimum]
        @maximum = @options[:maximum]
      end

      def apply(obj)
        value = obj.send(@property_name)
        length = value.length

        message = if @minimum && length < @minimum
                    :too_short
                  elsif @maximum && length > @maximum
                    :too_long
                  end

        if message
          obj.errors.add @property_name, message, @options.merge(length: length)
        end
      end
    end
  end
end
