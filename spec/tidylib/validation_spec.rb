require 'spec_helper'

describe Tidylib::Validation do
  it 'has a version number' do
    expect(Tidylib::Validation::VERSION).not_to be nil
  end

  describe "#valid?" do
    it "executes all the validation rules" do
      validator_class = Class.new do
        include Tidylib::Validation

        validate do
          foo_bar
          baz_hoo
        end

        def initialize(obj)
          @object = obj
        end

        def foo_bar
          errors.add(:foo_bar, :blank)
        end

        def baz_hoo
          errors.add(:baz_hoo, :whatevs)
        end
      end

      object = double
      validator = validator_class.new(object)

      validator.valid?

      expect(validator.errors.on(:foo_bar)).to_not be_empty
      expect(validator.errors.on(:baz_hoo)).to_not be_empty
    end

    it "returns true if there are no errors after applying validation rules" do
      validator_class = Class.new do
        include Tidylib::Validation

        validate do
          foo_bar
        end

        def foo_bar
        end
      end

      validator = validator_class.new

      expect(validator.valid?).to be_truthy
    end

    it "returns false if there are errors after applying validation rules" do
      validator_class = Class.new do
        include Tidylib::Validation

        validate do
          foo_bar
        end

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

        validate do
          foo_bar
        end

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

        validate do
          presence_of :foo
        end

        def foo; end
      end

      validator = validator_class.new

      expect(validator.valid?).to be_falsey

      expect(validator.errors.on(:foo)).to eq([ [:blank, {} ] ])
    end

    it "implements length validation dsl" do
      validator_class = Class.new do
        include Tidylib::Validation

        validate do
          length_of :foo, maximum: 4, minimum: 2
        end

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
