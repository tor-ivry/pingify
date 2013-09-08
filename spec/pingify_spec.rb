require 'minitest/autorun'
require 'pingify'
require 'webmock/minitest'

describe Pingify do
  let(:subject){
    Pingify::Runnable.new({:uri => 'http://uri/ping'})
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

    [500, 401, 404].each do |err_code|
      it "#{err_code} error" do
        stub_request(:any, 'uri/ping').to_return(:status => err_code)
        errs = subject.run.errors
        errs.wont_be_empty
      end
    end

    it 'no uri' do
      errs = subject.run.errors
      errs.wont_be_empty
    end
  end
end
