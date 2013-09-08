require "pinger/version"
require 'pinger/result'
require 'rest-client'

module Pinger

  def self.config(options={ :timeout => 2.0, :open_timeout => 2.0 })
    Runnable.new options
  end

  class Runnable
    attr_accessor :uri

    def initialize(options)
      @uri = options.delete :uri
      @times = options.delete(:times) || 4
      @http_opts = { :timeout => options.delete(:timeout), :open_timeout => options.delete(:open_timeout) }
    end

    def run
      res = RestClient.get(uri, @http_opts)
      ping_headers = Hash[res.headers.select{ |k,_| k.match(/^x_ping_/) }.map{ |k,v| [k.to_s.sub('x_ping_', '').to_sym, v] }]

      runtimes = @times - 1
      start = Time.now
      runtimes.times { RestClient.get(uri, @http_opts) }
      total_time = Time.now - start

      avg = total_time / runtimes

      data = { :average => avg }.merge(ping_headers)
      return Result.new(data)
    rescue
      return ErrorResult.new({}, [$!])
    end
  end
end







