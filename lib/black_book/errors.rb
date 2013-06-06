module BlackBook
  class BlackBookError < StandardError; end
  class VinNotFound < BlackBookError; end
  class MakesNotFound < BlackBookError; end
  class ModelsNotFound < BlackBookError; end
  class SeriesNotFound < BlackBookError; end
  class StylesNotFound < BlackBookError; end
end
