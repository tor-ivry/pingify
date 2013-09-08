module Pinger
  class Result
    attr_reader :errors
    attr_reader :data

    def initialize(data, errors = [])
      @data = data
      @errors = errors
    end

    def success?
      errors.none?
    end

    def average
      data[:average]
    end

    def test
      yield(data)
    end
  end

  class ErrorResult < Result
    def test(&block)
      false
    end
  end
end
