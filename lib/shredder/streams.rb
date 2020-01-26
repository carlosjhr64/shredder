module Shredder
  class Streams
    include Shredder
    # this one takes streams
    def initialize(sewn, shreds)
      @sewn   = sewn
      @shreds = shreds
    end
  end
end
