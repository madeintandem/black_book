require_relative "../minitest_helper"

describe BlackBook::UsedCars do
  it "returns a proper WSDL URL" do
    BlackBook::UsedCars.wsdl_url.must_equal "https://www.blackbookws.com/UsedCarWSX.asmx?WSDL"
  end

  describe "current valuation for a given VIN, mileage and state" do
    before do
      BlackBook.configure do |config|
        config.user_id = "xxxx"
        config.password = "xxxx"
      end
    end

    it "should have a list of services" do
      VCR.use_cassette("wsdl") do
        BlackBook::UsedCars.operations.must_include :get_current_vin_values
      end
    end

    it "should get the current values of a given VIN" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("valid_request") do
          BlackBook::UsedCars.current_valuation_for("1D7HW22K45S177616", 50_000, "IL")[:value_array].must_include :bb_value
        end
      end
    end

    it "should raise an exception when a VIN is not found" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("vin_not_found") do
          proc { BlackBook::UsedCars.current_valuation_for("NOT_FOUND", 50_000, "IL") }.must_raise BlackBook::VinNotFound
        end
      end
    end

    it "should raise an exception when passing bad request data" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("savon_error") do
          proc { BlackBook::UsedCars.current_valuation_for("1D7HW22K45S177616", "", "") }.must_raise BlackBook::BlackBookError
        end
      end
    end
  end
end