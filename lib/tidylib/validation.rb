require "tidylib/validation/version"
require 'tidylib/validation/dsl'
require 'tidylib/validation_errors'

module Tidylib
  module Validation
    def self.included(receiver)
      receiver.extend(DSL)
    end

    def valid?
      validation_rules.each do |validation_rule|
        self.send(validation_rule)
      end

      errors.empty?
    end

    def validation_rules
      self.class.validation_rules
    end

    def errors
      @errors ||= ValidationErrors.new
    end
  end
end
