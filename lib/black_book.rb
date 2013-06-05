require "black_book/version"
require "black_book/base_request"
require "black_book/used_cars"
require "black_book/errors"
require "symboltable"

require "ap"
require "debugger"

module BlackBook
  extend self

  def configure
    yield config
  end

  # Valid options:
  #   user_id
  #   password
  def config
    @@config ||= SymbolTable.new
  end
end
