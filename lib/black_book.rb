require "black_book/version"
require "black_book/base_request"
require "black_book/used_vehicle"
require "symboltable"

module BlackBook
  def configure
    yield config
  end

  def config
    @@config ||= SymbolTable.new
  end

  module_function :configure, :config
end
