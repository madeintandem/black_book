require "rest_client"


module BlackBook
  class UsedVehicle < BaseRequest
    class << self
      def endpoint
        "UsedVehicle"
      end

      def by_vin(vin)
        request("#{base_url}/#{endpoint}/VIN/#{vin}")
      end
    end
  end
end
