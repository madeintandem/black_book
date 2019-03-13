require "spec_helper"

describe BlackBook::UsedVehicle do
  let(:subject) { BlackBook::UsedVehicle }

  before do
    set_credentials
  end

  describe "::by_vin" do
    it "is a BaseRequest" do
      expect(BlackBook::UsedVehicle.new).to be_a(BlackBook::BaseRequest)
    end

    it "has an endpoint of UsedVehicle" do
      expect(subject.endpoint).to eq("UsedVehicle")
    end

    it "returns a Hash from the response json" do
      VCR.use_cassette("UsedVehicle_by_vin") do
        response = BlackBook::UsedVehicle.by_vin("2C4RDGBG1CR385500")
        expect(response["used_vehicles"]).not_to be_empty
      end
    end
  end
end
