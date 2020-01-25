module Shredder
  class Streams
    include Shredder

    attr_reader :sewn, :shreds
    # this one takes streams
    def initialize(sewn, shreds)
      @sewn   = sewn
      @shreds = shreds
    end
  end
end
