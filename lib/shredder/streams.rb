module Shredder
  class Streams
    # this one takes streams
    def initialize(sew,shreds,limit=0)
      @sew = sew
      @shreds = shreds
      @limit = limit
    end

    def shred(limit=@limit)
      Shredder.shred(@sew,@shreds,limit)
    end

    def sew(limit=@limit)
      Shredder.sew(@sew,@shreds,limit)
    end
  end
end
