module BlackBook
  class UsedCars < BaseRequest
    class << self
      def wsdl_url
        "https://www.blackbookws.com/UsedCarWSX.asmx?WSDL"
      end

      def current_valuation_for(vin, mileage, state, options={})
        response = request(:get_current_vin_values, {
          "sCountryCode" => "U",
          "sFrequencyCode" => "W",
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
        raise BlackBookError if envelope[:header][:user_credentials][:returncode] != "0"

        envelope[:body][:current_vin_values_response][:current_vin_values_result]
      rescue Savon::SOAPFault => e
        raise BlackBookError.new e
      end
    end
  end
end
