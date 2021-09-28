module Shredder
  class Files
    include Shredder
    # this one takes filenames
    def initialize(sewn, shreds=sewn, m=2, n: m)
      @sewn   = sewn
      @shreds = shred_files(shreds, n)
      raise "Need at least 2 shreds" unless @shreds.length > 1
    end

    def shred(limit=0)
      reader = writers = count = nil
      begin
        reader  = File.open(@sewn, 'r')
        writers = @shreds.map{File.open _1, 'wb'}
        count   = Streams.new(reader, writers).shred(limit: limit)
      ensure
        writers.each{_1.close}  if writers
        reader.close            if reader
      end
      return count
    end

    def sew(limit=0)
      writer = readers = count = nil
      begin
        writer  = File.open(@sewn, 'wb')
        readers = @shreds.map{File.open(_1, 'r')}
        count   = Streams.new(writer, readers).sew(limit: limit)
      ensure
        writer.close            if writer
        readers.each{_1.close}  if readers
      end
      return count
    end
  end
end
