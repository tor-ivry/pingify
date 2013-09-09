require 'minitest/autorun'
require 'pingify'

describe "network" do
  before do
    WebMock.allow_net_connect!
  end

  describe "google.com" do
    it 'does not fail' do
      res = Pingify::Runnable.new({uri: 'http://google.com'}).run
      res.success?.must_equal true
      res.average.must_be_close_to 0.3, 1
    end
  end

  describe "example.com" do
    it "fails" do
      res = Pingify::Runnable.new({uri: 'http://localhost:10000', :timeout => 0.001}).run
      res.success?.wont_equal true
    end

  end
end
