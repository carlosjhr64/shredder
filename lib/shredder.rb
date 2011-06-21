module Shredder
  VERSION = '0.1.0'

  # note that these are streams
  def self.shred(reader,writers,limit=0)
    shreds = writers.length
    xor = count = 0
    while byte = reader.getbyte do
      writers[ count % shreds ].putc byte^xor
      xor = byte
      count += 1
      # note: will not break if limit is zero
      break if count == limit
    end
    return count
  end

  # note that these are streams
  def self.sew(writer,readers,limit=0)
    shreds = readers.length
    xor = count = 0
    while byte = readers[ count % shreds ].getbyte do
      chr = byte^xor
      xor = chr
      writer.putc chr
      count += 1
      # note: will not break if limit is zero
      break if count == limit
    end
    return count
  end

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

  class Files
     # this one takes filenames
    def initialize(sew,shreds,limit=0)
      @sew = sew
      @shreds = shreds
      @limit = limit
    end

    def shred(limit=@limit)
      reader = File.open(@sew,'r')
      writers = []
      @shreds.each{|shred| writers.push( File.open(shred,'wb') ) }

      count = nil
      begin
        count = Shredder.shred( reader, writers, limit )
      rescue Exception
        raise $!
      ensure
        writers.each{|writer| writer.close}
        reader.close
       end

      return count
    end

    def sew(limit=@limit)
      writer = File.open(@sew,'wb')
      readers = []
      @shreds.each{|shred| readers.push( File.open(shred,'r') ) }

      count = nil
      begin
        count = Shredder.sew( writer, readers, limit )
      rescue Exception
        raise $!
      ensure
        writer.close
        readers.each{|reader| reader.close}
      end

      return count
    end
  end

end
