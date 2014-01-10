module SHREDDER

  class Streams
    extend Functions 

    # this one takes streams
    def initialize(sew, shreds, limit=0)
      @sew    = sew
      @shreds = shreds
      @limit  = limit
    end

    def shred(limit=@limit)
      Streams.shred(@sew,@shreds,limit)
    end

    def sew(limit=@limit)
      Streams.sew(@sew,@shreds,limit)
    end

  end

end
