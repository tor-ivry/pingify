module Pingify
  class Result
    attr_reader :errors

    def initialize(data, errors = [])
      @data = data
      @errors = errors
    end

    def data
      return yield(@data) if block_given?
      @data
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
