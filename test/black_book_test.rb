require_relative "minitest_helper"

describe BlackBook do
  before do
    BlackBook.remove_class_variable :@@config if BlackBook.class_variable_defined? :@@config
  end

  it "should yield a configuration object to block" do
    BlackBook.configure do |config|
      config.foo = "bar"
    end

    BlackBook.config.foo.must_equal "bar"
  end
end
