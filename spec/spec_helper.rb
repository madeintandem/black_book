$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require "awesome_print"
require "rspec"
require "black_book"
require "pry"
require "pry-nav"
require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock
end


def set_credentials(user_id="test_user", password="test_password")
  BlackBook.configure do |config|
    config.user_id = user_id
    config.password = password
  end
end
