module SHREDDER

  class Files
    extend Functions

     # this one takes filenames
    def initialize(sew, shreds, limit=0)
      @sew    = sew
      @shreds = shreds
      @limit  = limit
    end

    def shred(limit=@limit)
      reader  = File.open(@sew, 'r')
      writers = []
      @shreds.each{|shred| writers.push(File.open(shred, 'wb'))}

      count = nil
      begin
        count = Files.shred(reader, writers, limit)
      rescue Exception
        raise $!
      ensure
        writers.each{|writer| writer.close}
        reader.close
       end

      return count
    end

    def sew(limit=@limit)
      writer  = File.open(@sew, 'wb')
      readers = []
      @shreds.each{|shred| readers.push(File.open(shred, 'r'))}

      count = nil
      begin
        count = Files.sew(writer, readers, limit)
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
