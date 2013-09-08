require "pinger/version"
require 'pinger/result'
require 'rest-client'

module Pinger
  class Runnable

    attr_accessor :uri

    def initialize(options={ :timeout => 2.0, :open_timeout => 2.0 })      @uri = options.delete :uri
      @times = options.delete(:times) || 4
      @http_opts = { :timeout => options.delete(:timeout), :open_timeout => options.delete(:open_timeout) }
    end

    def run
      res = ping!
      ping_headers = Hash[res.headers.select{ |k,_| k.match(/^x_ping_/) }.map{ |k,v| [k.to_s.sub('x_ping_', '').to_sym, v] }]

      runtimes = @times - 1
      start = Time.now
      runtimes.times { ping! }
      total_time = Time.now - start

      avg = total_time / runtimes

      data = { :average => avg, :body => res.body }.merge(ping_headers)
      return Result.new(data)
    rescue
      return ErrorResult.new({}, [$!])
    end

    private 

    def ping!
      RestClient.get(uri, @http_opts)
    end
  end
end
