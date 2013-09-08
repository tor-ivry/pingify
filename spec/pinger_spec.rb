require 'minitest/autorun'
require 'mocha/setup'
require 'pinger'
require 'webmock/minitest'

describe Pinger do
  let(:subject){
    Pinger.config({:uri => 'http://uri/ping'})
  }

  describe 'general ping' do
    it 'returns runnable object' do
      subject.respond_to?(:run).must_equal true
    end

    it 'extracts proper ping headers' do
      stub_request(:any, 'uri/ping').to_return(:headers => { 'x-ping-appversion' => 1.0 })
      res = subject.run
      res.success?.must_equal false
      res.data[:appversion].must_equal "1.0"
    end
  end

  describe 'time pings' do
    before do
      stub_request(:any, 'uri/ping')
    end

    it "returns average of pings" do
      refute_equal subject.run.data[:average], nil
    end

  end


  describe 'integration' do 
    it "should blah" do
    end
  end
end

