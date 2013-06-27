module BlackBook
  class BlackBookError < StandardError; end

  class VinNotFound < BlackBookError
    def to_s
      "VIN not found"
    end
  end

  class MakesNotFound < BlackBookError
    def to_s
      "makes not found"
    end
  end

  class ModelsNotFound < BlackBookError
    def to_s
      "models not found"
    end
  end

  class SeriesNotFound < BlackBookError
    def to_s
      "series not found"
    end
  end

  class StylesNotFound < BlackBookError
    def to_s
      "styles not found"
    end
  end
end
