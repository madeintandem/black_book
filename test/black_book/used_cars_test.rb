require_relative "../minitest_helper"

describe BlackBook::UsedCars do
  it "returns a proper WSDL URL" do
    BlackBook::UsedCars.wsdl_url.must_equal "https://www.blackbookws.com/UsedCarWSX.asmx?WSDL"
  end

  describe "values" do
    before do
      BlackBook.configure do |c|
        c.user_id = "BlockL"
        c.password = "BlockL"
      end
    end

    it "should have a list of services" do
      BlackBook::UsedCars.operations.must_include :get_current_vin_values
    end

    it "should get the current values of a given VIN" do
      ap BlackBook::UsedCars.current_values_for("1D7HW22K45S177616", 50_000, "IL").hash
    end

    # def find_styles
      # VCR.use_cassette("wsdl") do
        # VCR.use_cassette("2013/divisions/13/models/24997/styles") do
          # @models = BlackBook::Style.find_all_by_model_id(24997) # 2013 Ford Mustang
        # end
      # end
    # end

    # it "returns array of Style objects" do
    #   find_styles

    #   @models.first.must_be_instance_of BlackBook::Style
    #   @models.size.must_equal 11
    # end
  end
end