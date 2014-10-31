require "black_book/version"

module BlackBook
  def configure
    yield config
  end

  # Valid options:
  #   user_id
  #   password
  def config
    @@config ||= SymbolTable.new
  end

  module_function :configure, :config
end
