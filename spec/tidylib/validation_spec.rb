require 'spec_helper'

describe Tidylib::Validation do
  it 'has a version number' do
    expect(Tidylib::Validation::VERSION).not_to be nil
  end

  describe "#valid?" do
    it "executes all the validation rules" do
      validator_class = Class.new do
        include Tidylib::Validation

        validate :foo_bar
        validate :baz_hoo

        def initialize(obj)
          @object = obj
        end

        def foo_bar
          @object.send(:invoked_foo_bar)
        end

        def baz_hoo
          @object.send(:invoked_baz_hoo)
        end
      end

      object = double
      validator = validator_class.new(object)

      expect(object).to receive(:invoked_foo_bar)
      expect(object).to receive(:invoked_baz_hoo)

      validator.valid?
    end

    it "returns true if there are no errors after applying validation rules" do
      validator_class = Class.new do
        include Tidylib::Validation

        validate :foo_bar

        def foo_bar
        end
      end

      validator = validator_class.new

      expect(validator.valid?).to be_truthy
    end

    it "returns false if there are errors after applying validation rules" do
      validator_class = Class.new do
        include Tidylib::Validation

        validate :foo_bar

        def foo_bar
          errors.add(:foo, :bar)
        end
      end

      validator = validator_class.new

      expect(validator.valid?).to be_falsey
    end
  end
end
