# BlackBook

Provides a ruby interface for the Black Book's API.
Read more about it here: http://www.blackbookauto.com

## Installation

Add this line to your application's Gemfile:

    gem 'black_book'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install black_book

## Usage

To start, use a configuration block to set up your credentials:

    BlackBook.configure do |config|
      config.user_id = "xxxx"
      config.password = "xxxx"
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
