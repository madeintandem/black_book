require "spec_helper"

describe BlackBook::BaseRequest do
  let(:subject) { BlackBook::BaseRequest }

  before do
    set_credentials
  end

  describe "::base_url" do
    it "has a base_url" do
      expect(subject.base_url).to eq("https://service.blackbookcloud.com/UsedCarWS/UsedCarWS")
    end
  end

  describe "::request" do
    context "when credentials are missing" do
      it "throws an error if no credentials are set" do
        set_credentials(nil, nil)
        expect{ subject.request("test") }.to raise_error("Credentials not set")
      end
    end

    context "with valid credentials" do
      it "executes the request" do
        VCR.use_cassette("BaseRequest_request") do
          response = subject.request("#{subject.base_url}/UsedVehicle/VIN/2C4RDGBG1CR385500")
          expect(JSON.parse(response)).to have_key("used_vehicles")
        end
      end
    end
  end

  describe "::credentials_missing?" do
    it "returns true if no credentials are set" do
      set_credentials(nil, nil)
      expect(subject.credentials_missing?).to eq(true)
    end

    it "returns false if credentials are set" do
      expect(subject.credentials_missing?).to eq(false)
    end
  end
end
