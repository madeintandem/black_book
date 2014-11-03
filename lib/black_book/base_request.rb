module BlackBook
  class BaseRequest
    class << self
      def base_url
        "https://service.blackbookcloud.com/UsedCarWS/UsedCarWS"
      end

      def request(url, options={})
        raise "Credentials not set" if credentials_missing?
        response = RestClient::Request.new(
          method: :get,
          url: url,
          user: BlackBook.config.user_id,
          password: BlackBook.config.password,
          headers: { accept: :json, content_type: :json }
        ).execute
      end

      def credentials_missing?
        !(BlackBook.config.user_id && BlackBook.config.password)
      end
    end
  end
end
