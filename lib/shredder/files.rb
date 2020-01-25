module Shredder
  class Files
    attr_reader :sewn, :shreds
    # this one takes filenames
    def initialize(sewn, shreds)
      @sewn   = sewn
      @shreds = shreds
    end

    def shred(limit=0)
      reader = writers = count = nil
      begin
        reader  = File.open(@sewn, 'r')
        writers = @shreds.map{|shred| File.open(shred, 'wb')}
        count   = Streams.new(reader, writers).shred(limit: limit)
      ensure
        writers.each{|writer| writer.close}  if writers
        reader.close                         if reader
      end
      return count
    end

    def sew(limit=0)
      writer = readers = count = nil
      begin
        writer  = File.open(@sew, 'wb')
        readers = @shreds.map{|shred| File.open(shred, 'r')}
        count   = Streams.new(writer, readers).sew(limit: limit)
      ensure
        writer.close
        readers.each{|reader| reader.close}
      end
      return count
    end
  end
end
