require 'minitest/autorun'
require 'pinger/result'

describe Pinger::Result do
  let(:result){
    Pinger::Result.new(average: 1.0)
  }
  it 'passes on predicate' do
    test = result.test do |d|
      d[:average] < 2
    end
    assert test
  end

  it "fails on predicate" do
    test = result.test do |d|
      d[:average] > 2
    end
    refute test
  end
end
