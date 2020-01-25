module Shredder
  class StdIO
    attr_reader :shreds
    # this one takes shred filenames and uses $stdin or $stdout appropriately.
    def initialize(shreds)
      @shreds = shreds
    end

    def shred(limit=0)
      writers = count = nil
      begin
        writers = @shreds.map{|shred| File.open(shred, 'wb')}
        count   = Streams.new($stdin, writers).shred(limit: limit)
      ensure
        writers.each{|writer| writer.close}  if writers
      end
      return count
    end

    def sew(limit=0)
      readers = count = nil
      begin
        readers = @shreds.map{|shred| File.open(shred, 'r')}
        count   = Streams.new($stdout, readers).sew(limit: limit)
      ensure
        readers.each{|reader| reader.close}
      end
      return count
    end
  end
end
