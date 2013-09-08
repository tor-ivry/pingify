require 'minitest/autorun'
require 'pinger'

describe "google.com" do
  it 'does not fail' do
    res = Pinger::Runnable.new({uri: 'http://google.com'}).run
    res.success?.must_equal true
    p res.data
    res.average.must_be_close_to 0.3, 1
  end
end

describe "example.com" do
  it "fails" do
    res = Pinger::Runnable.new({uri: 'http://localhost:10000', :timeout => 0.001}).run
    res.success?.wont_equal true
  end

end