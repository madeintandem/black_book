module BlackBook
  class BaseRequest
    class << self
      def base_url
        "https://#{credentials}@service.blackbookcloud.com/UsedCarWS/UsedCarWS"
      end

      def credentials
        "#{BlackBook.config.user_id}:#{BlackBook.config.password}"
      end

      def request(url, options={})
        request_options = default_options.merge(options).map { |k,v| "#{k}=#{v}" }.join("&")
        RestClient.get "#{url}?#{request_options}", accept: :json
      end

      def default_options
        { customerid: BlackBook.config.user_id }
      end
    end
  end
end
