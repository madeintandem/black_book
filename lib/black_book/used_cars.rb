module BlackBook
  class UsedCars < BaseRequest
    class << self
      def wsdl_url
        "https://www.blackbookws.com/UsedCarWSX.asmx?WSDL"
      end

      def current_values_for(vin, mileage, state, options={})
        request(:get_current_vin_values, {
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
      end
    end
  end
end
