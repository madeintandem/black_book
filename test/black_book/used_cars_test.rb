require_relative "../minitest_helper"

describe BlackBook::UsedCars do
  before do
    BlackBook.configure do |config|
      config.user_id = "xxxxx"
      config.password = "xxxxx"
    end
  end

  it "returns a proper WSDL URL" do
    BlackBook::UsedCars.wsdl_url.must_equal "https://www.blackbookws.com/UsedCarWSX.asmx?WSDL"
  end

  describe "current valuation for a given VIN, mileage and state" do
    it "should have a list of services" do
      VCR.use_cassette("wsdl") do
        BlackBook::UsedCars.operations.must_include :get_current_vin_values
      end
    end

    it "should get the current values of a given VIN" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("valid_request") do
          BlackBook::UsedCars.current_valuation_from_vin("1D7HW22K45S177616", 50_000, "IL")[:value_array].must_include :bb_value
        end
      end
    end

    it "should raise an exception when a VIN is not found" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("vin_not_found") do
          proc { BlackBook::UsedCars.current_valuation_from_vin("NOT_FOUND", 50_000, "IL") }.must_raise BlackBook::VinNotFound
        end
      end
    end

    it "should raise an exception when passing bad request data" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("savon_error") do
          proc { BlackBook::UsedCars.current_valuation_from_vin("1D7HW22K45S177616", "", "") }.must_raise BlackBook::BlackBookError
        end
      end
    end
  end

  describe "current valuation for make, model, series, and style" do
    it "should have a list of services" do
      VCR.use_cassette("wsdl") do
        BlackBook::UsedCars.operations.must_include :get_current_values
      end
    end

    it "should get the current values" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("value_valid_request") do
          BlackBook::UsedCars.current_valuation_from_data(2013, 'Ford', 'Fiesta', 'SE', '4D Hatchback', 10_000, 'IL')[:value_array].must_include :bb_value
        end
      end
    end

    it "should raise an exception when passing bad request data" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("value_savon_error") do
          proc { BlackBook::UsedCars.current_valuation_from_data(2013, 'Ford', 'Fiesta', 'SE', '4D Hatchback',10_000, 'IL', {country: "INVALID"}) }.must_raise BlackBook::BlackBookError
        end
      end
    end
  end

  describe "years" do
    it "should have a list of services" do
      VCR.use_cassette("wsdl") do
        BlackBook::UsedCars.operations.must_include :get_years
      end
    end

    it "should get the current years" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("years_valid_request") do
          BlackBook::UsedCars.years.must_include "2013"
        end
      end
    end

    it "should raise an exception when passing bad request data" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("years_savon_error") do
          proc { BlackBook::UsedCars.years({country: "INVALID"}) }.must_raise BlackBook::BlackBookError
        end
      end
    end
  end

  describe "makes" do
    it "should have a list of services" do
      VCR.use_cassette("wsdl") do
        BlackBook::UsedCars.operations.must_include :get_makes
      end
    end

    it "should get the current years" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("makes_valid_request") do
          BlackBook::UsedCars.makes(2013).must_include "Ford"
        end
      end
    end

    it "should raise an exception when passing bad request data" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("make_savon_error") do
          proc { BlackBook::UsedCars.makes(2013, {country: "INVALID"}) }.must_raise BlackBook::BlackBookError
        end
      end
    end

    it "should raise an exception when no vehicles are found" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("makes_error") do
          proc { BlackBook::UsedCars.makes(1864) }.must_raise BlackBook::MakesNotFound
        end
      end
    end
  end

  describe "models" do
    it "should have a list of services" do
      VCR.use_cassette("wsdl") do
        BlackBook::UsedCars.operations.must_include :get_models
      end
    end

    it "should get the current years" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("models_valid_request") do
          BlackBook::UsedCars.models(2013, 'Ford').must_include "Fiesta"
        end
      end
    end

    it "should raise an exception when passing bad request data" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("model_savon_error") do
          proc { BlackBook::UsedCars.models(2013, 'Ford', {country: "INVALID"}) }.must_raise BlackBook::BlackBookError
        end
      end
    end

    it "should raise an exception when no vehicles are found" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("model_error") do
          proc { BlackBook::UsedCars.models(1864, 'Ford') }.must_raise BlackBook::ModelsNotFound
        end
      end
    end
  end

  describe "series" do
    it "should have a list of services" do
      VCR.use_cassette("wsdl") do
        BlackBook::UsedCars.operations.must_include :get_series
      end
    end

    it "should get the current series" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("series_valid_request") do
          BlackBook::UsedCars.series(2013, 'Ford', 'Fiesta').must_include "SE"
        end
      end
    end

    it "should raise an exception when passing bad request data" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("series_savon_error") do
          proc { BlackBook::UsedCars.series(2013, 'Ford', 'Fiesta', {country: "INVALID"}) }.must_raise BlackBook::BlackBookError
        end
      end
    end

    it "should raise an exception when no vehicles are found" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("series_error") do
          proc { BlackBook::UsedCars.series(1864, 'Ford', 'Fiesta') }.must_raise BlackBook::SeriesNotFound
        end
      end
    end
  end

  describe "styles" do
    it "should have a list of services" do
      VCR.use_cassette("wsdl") do
        BlackBook::UsedCars.operations.must_include :get_styles
      end
    end

    it "should get the current styles" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("styles_valid_request") do
          BlackBook::UsedCars.styles(2013, 'Ford', 'Fiesta', 'SE').must_include "4D Hatchback"
        end
      end
    end

    it "should raise an exception when passing bad request data" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("style_savon_error") do
          proc { BlackBook::UsedCars.styles(2013, 'Ford', 'Fiesta', 'SE', {country: "INVALID"}) }.must_raise BlackBook::BlackBookError
        end
      end
    end

    it "should raise an exception when no vehicles are found" do
      VCR.use_cassette("wsdl") do
        VCR.use_cassette("styles_error") do
          proc { BlackBook::UsedCars.styles(1864, 'Ford', 'Fiesta', 'SE') }.must_raise BlackBook::StylesNotFound
        end
      end
    end
  end
end
