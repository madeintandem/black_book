module BlackBook
  class UsedCars < BaseRequest
    class << self
      def wsdl_url
        "https://www.blackbookws.com/UsedCarWSX.asmx?WSDL"
      end

      def current_valuation_from_vin(vin, mileage, state, options={})
        response = request(:get_current_vin_values, {
          "sCountryCode" => (options[:country] || "U"),
          "sFrequencyCode" => (options[:frequency] || "W"),
          "sVIN" => vin,
          "iMileage" => mileage,
          "sState" => state,
          "iExtraCleanAddDeductAdj" => (options[:extra_clean_adjustment] || 0),
          "iCleanAddDeductAdj" => (options[:clean_adjustment] || 0),
          "iAverageAddDeductAdj" => (options[:average_adjustment] || 0),
          "iRoughAddDeductAdj" => (options[:rough_adjustment] || 0),
          "bFillDrilldown" => "false",
          "bReturnMileage" => "true",
          "bReturnAddDeducts" => "true"
        })

        envelope = response.hash[:envelope]

        raise VinNotFound if envelope[:header][:user_credentials][:returncode] == "20"
        raise BlackBookError.new(envelope[:header][:user_credentials][:returnmessage]) if envelope[:header][:user_credentials][:returncode] != "0"

        envelope[:body][:current_vin_values_response][:current_vin_values_result]
      rescue Savon::SOAPFault => e
        raise BlackBookError.new e
      end

      def current_valuation_from_data(year, make, model, series, style, mileage, state, options={})
        response = request(:get_current_values, {
          "sCountryCode" => (options[:country] || "U"),
          "sFrequencyCode" => (options[:frequency] || "W"),
          "sYear" => year,
          "sMake" => make,
          "sModel" => model,
          "sSeries" => series,
          "sStyle" => style,
          "iMileage" => mileage,
          "sState" => state,
          "iExtraCleanAddDeductAdj" => (options[:extra_clean_adjustment] || 0),
          "iCleanAddDeductAdj" => (options[:clean_adjustment] || 0),
          "iAverageAddDeductAdj" => (options[:average_adjustment] || 0),
          "iRoughAddDeductAdj" => (options[:rough_adjustment] || 0),
          "bFillDrilldown" => "false",
          "bReturnMileage" => "true",
          "bReturnAddDeducts" => "true"
        })

        envelope = response.hash[:envelope]

        raise VehicleNotFound if envelope[:header][:user_credentials][:returncode] == "20"
        raise BlackBookError.new(envelope[:header][:user_credentials][:returnmessage]) if envelope[:header][:user_credentials][:returncode] != "0"

        envelope[:body][:current_values_response][:current_values_result]
      rescue Savon::SOAPFault => e
        raise BlackBookError.new e
      end

      def years(options={})
        response = request(:get_years, {
          "sCountryCode" => (options[:country] || "U")
        })

        envelope = response.hash[:envelope]

        raise BlackBookError.new(envelope[:header][:user_credentials][:returnmessage]) if envelope[:header][:user_credentials][:returncode] != "0"

        envelope[:body][:years_response][:years_result][:years][:year]
      rescue Savon::SOAPFault => e
        raise BlackBookError.new e
      end

      def makes(year, options={})
        response = request(:get_makes, {
          "sCountryCode" => (options[:country] || "U"),
          "sYear" => year
        })

        envelope = response.hash[:envelope]

        raise BlackBookError.new(envelope[:header][:user_credentials][:returnmessage]) if envelope[:header][:user_credentials][:returncode] != "0"
        raise MakesNotFound if envelope[:body][:makes_response][:makes_result][:makes].nil?

        envelope[:body][:makes_response][:makes_result][:makes][:make]
      rescue Savon::SOAPFault => e
        raise BlackBookError.new e
      end

      def models(year, make, options={})
        response = request(:get_models, {
          "sCountryCode" => (options[:country] || "U"),
          "sYear" => year,
          "sMake" => make
        })

        envelope = response.hash[:envelope]

        raise BlackBookError.new(envelope[:header][:user_credentials][:returnmessage]) if envelope[:header][:user_credentials][:returncode] != "0"
        raise ModelsNotFound if envelope[:body][:models_response][:models_result][:models].nil?

        envelope[:body][:models_response][:models_result][:models][:model]
      rescue Savon::SOAPFault => e
        raise BlackBookError.new e
      end

      def series(year, make, model, options={})
        response = request(:get_series, {
          "sCountryCode" => (options[:country] || "U"),
          "sYear" => year,
          "sMake" => make,
          "sModel" => model
        })

        envelope = response.hash[:envelope]

        raise BlackBookError.new(envelope[:header][:user_credentials][:returnmessage]) if envelope[:header][:user_credentials][:returncode] != "0"
        raise SeriesNotFound if envelope[:body][:series_response][:series_result][:series].nil?

        envelope[:body][:series_response][:series_result][:series][:vehseries]
      rescue Savon::SOAPFault => e
        raise BlackBookError.new e
      end

      def styles(year, make, model, series, options={})
        response = request(:get_styles, {
          "sCountryCode" => (options[:country] || "U"),
          "sYear" => year,
          "sMake" => make,
          "sModel" => model,
          "sSeries" => series
        })

        envelope = response.hash[:envelope]

        raise BlackBookError.new(envelope[:header][:user_credentials][:returnmessage]) if envelope[:header][:user_credentials][:returncode] != "0"
        raise StylesNotFound if envelope[:body][:body_styles_response][:body_styles_result][:styles].nil?

        envelope[:body][:body_styles_response][:body_styles_result][:styles][:style]
      rescue Savon::SOAPFault => e
        raise BlackBookError.new e
      end
    end
  end
end
