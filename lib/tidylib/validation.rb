require "tidylib/validation/version"
require 'tidylib/validation/dsl'
require 'tidylib/validation_errors'

module Tidylib
  module Validation
    def self.included(receiver)
      receiver.extend(DSL)
    end

    def valid?
      errors.clear

      custom_validations.each do |validation_rule|
        self.send(validation_rule)
      end

      property_validations.each do |property_validation|
        property_name = property_validation.property
        value = self.send(property_name)
        error = property_validation.error_for(value)
        if error
          errors.add(*error)
        end
      end

      errors.empty?
    end

    def custom_validations
      self.class.custom_validations
    end

    def property_validations
      self.class.property_validations
    end

    def errors
      @errors ||= ValidationErrors.new
    end
  end
end
