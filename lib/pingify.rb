require "pingify/version"
require 'pingify/result'
require 'rest-client'

module Pingify
  class Runnable

    attr_accessor :uri

    def initialize(options={ :timeout => 2.0, :open_timeout => 2.0 })
      @uri = options.delete :uri
      @times = options.delete(:times) || 4
      @http_opts = { :timeout => options.delete(:timeout), :open_timeout => options.delete(:open_timeout) }
    end

    def run
      res = ping!

      data = { :average => average_time(@times - 1), :body => res.body }.merge(ping_headers(res))

      return Result.new(data)
    rescue
      return ErrorResult.new({}, [$!])
    end

    private

    def average_time(runtimes)
      start = Time.now
      runtimes.times { ping! }
      total_time = Time.now - start

      total_time / runtimes
    end

    def ping_headers(result)
      Hash[result.headers.select{ |k,_| k.match(/^x_ping_/) }.map{ |k,v| [k.to_s.sub('x_ping_', '').to_sym, v] }]
    end

    def ping!
      RestClient.get(uri, @http_opts)
    end
  end
end
