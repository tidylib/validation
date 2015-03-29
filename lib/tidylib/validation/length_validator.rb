module Tidylib
  module Validation
    class LengthValidator
      def self.for(property_name, options)
        Proc.new do
          value = send(property_name)
          length = value.length
          minimum = options[:minimum]
          maximum = options[:maximum]

          message = if minimum && length < minimum
                      :too_short
                    elsif maximum && length > maximum
                      :too_long
                    end

          if message
            errors.add property_name, message, options.merge(length: length)
          end
        end
      end
    end
  end
end
