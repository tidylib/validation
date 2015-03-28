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

    it "clears the errors before runnign validation" do
      validator_class = Class.new do
        include Tidylib::Validation

        validate :foo_bar

        def foo_bar
          errors.add(:foo, :bar)
        end
      end

      validator = validator_class.new
      validator.valid?
      validator.valid?
      expect(validator.errors.count).to eq(1)
    end

    it "implements presence dsl validation" do
      validator_class = Class.new do
        include Tidylib::Validation

        validates_presence_of :foo

        def foo; end
      end

      validator = validator_class.new

      expect(validator.valid?).to be_falsey

      expect(validator.errors.on(:foo)).to eq([ [:blank, {} ] ])
    end

    it "implements length validation dsl" do
      validator_class = Class.new do
        include Tidylib::Validation

        validates_length_of :foo, maximum: 4, minimum: 2

        def foo; [1]; end
      end

      validator = validator_class.new
      expect(validator.valid?).to be_falsey
      error = [
        :too_short,
        { maximum: 4, minimum: 2, length: 1 }
      ]
      expect(validator.errors.on(:foo)).to eq([ error ])
    end
  end
end
