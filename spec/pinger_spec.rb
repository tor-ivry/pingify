require 'minitest/autorun'
require 'mocha/setup'
require 'pinger'
require 'webmock/minitest'

describe Pinger do
  let(:subject){
    Pinger::Runnable.new({:uri => 'http://uri/ping'})
  }

  describe 'general ping' do
    it 'returns runnable object' do
      subject.must_respond_to(:run)
    end

    it 'extracts proper ping headers' do
      stub_request(:any, 'uri/ping').to_return(:headers => { 'x-ping-appversion' => 1.0 })
      res = subject.run
      res.success?.must_equal true
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

  describe 'errors' do
    it 'timeout error' do
      stub_request(:any, 'uri/ping').to_timeout
      errs = subject.run.errors
      errs.wont_be_empty
      errs[0].class.must_equal RestClient::RequestTimeout
    end

    it 'no uri' do
      errs = subject.run.errors
      errs.wont_be_empty
    end
  end
end
