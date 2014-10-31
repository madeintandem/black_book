require "spec_helper"

describe BlackBook::BaseRequest do
  let(:subject) { BlackBook::BaseRequest }
  before do
    BlackBook.configure do |config|
      config.user_id = "user_id"
      config.password = "password"
    end
  end

  describe "::credentials" do
    it "has the config credentials" do
      expect(subject.credentials).to eq("#{BlackBook.config.user_id}:#{BlackBook.config.password}")
    end
  end

  describe "::base_url" do
    it "has a base_url" do
      expect(subject.base_url).to eq("https://#{subject.credentials}@service.blackbookcloud.com/UsedCarWS/UsedCarWS/")
    end
  end

  describe "::request" do
    it "fires a rest request with json headers" do
      allow(RestClient).to receive(:get)

      expect(RestClient).to receive(:get).with("test_url?customerid=#{BlackBook.config.user_id}&test=options", accept: :json)

      subject.request("test_url", { test: :options })
    end
  end

  describe "::default_options" do
    it "has default options" do
      expect(subject.default_options).to eq(customerid: BlackBook.config.user_id)
    end
  end
end
