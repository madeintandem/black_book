require "spec_helper"

describe BlackBook do
  it "has a version" do
    expect(BlackBook::VERSION).to match(/\d\.\d\.\d/)
  end

  describe "#config" do
    it "has a config symbol table" do
      expect(BlackBook.config).to be_a(SymbolTable)
    end
  end

  describe "#configure" do
    it "yields the config table" do
      BlackBook.configure do |config|
        config.stuff = "test"
      end
      expect(BlackBook.config.stuff).to eq("test")
    end
  end
end
