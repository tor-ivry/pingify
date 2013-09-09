# Pingify

Pingify is a simple library that enables simple ping checks on running service


## Installation

Add this line to your application's Gemfile:

    gem 'pingify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pingify

## Usage

First define a Pingify object with the options you like

    pingify = Pingify::Runnable.new(
      uri: "http://example.com/ping", # service ping uri
      timeout: 4,                     # http timeout
      open_timeout: 4,                # http open timeout
      times: 10)                      # number of times to run

Run the test with #run

    result = pingify.run

Query the result

    result.success?

Result data, headers that begin with 'x-ping-' will be added to the hash.

    result.data[:average]     # average ping time
    result.data[:body]        # result body
    result.data[:appversion]  # flitered result header *x-ping-appversion*

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
