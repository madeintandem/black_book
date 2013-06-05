module BlackBook
  class BlackBookError < StandardError; end
  class VinNotFound < BlackBookError; end
end
