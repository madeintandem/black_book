require "savon"

module BlackBook
  class BaseRequest
    class << self
      def request(operation, data)
        client.call(operation, message: data)
      end

      def client
        @@client ||= Savon.client(wsdl: wsdl_url, soap_header: credentials, log: false)
      end

      def operations
        @@operations ||= client.operations
      end

      def credentials
        @@credentials ||= %|<UserCredentials xmlns="https://blackbookws.com/UsedCarWSX">
            <userid>#{BlackBook.config.user_id}</userid>
            <password>#{BlackBook.config.password}</password>
            <customer/>
            <producttype>W</producttype>
            <returncode>0</returncode>
            <returnmessage/>
          </UserCredentials>|
      end

      def wsdl_url
        raise NotImplementedError, "should have a WSDL URL"
      end
    end
  end
end
