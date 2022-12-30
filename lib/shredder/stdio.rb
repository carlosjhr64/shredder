module Shredder
  class StdIO
    include Shredder
    # this one takes shred filenames and uses $stdin or $stdout appropriately.
    def initialize(...)
      @shreds = shred_files(...)
    end

    def shred(limit=0)
      writers = count = nil
      begin
        writers = @shreds.map{File.open _1, 'wb'}
        count   = Streams.new($stdin, writers).shred(limit: limit)
      ensure
        writers.each{_1.close}  if writers
      end
      return count
    end

    def sew(limit=0)
      readers = count = nil
      begin
        readers = @shreds.map{File.open _1, 'r'}
        count   = Streams.new($stdout, readers).sew(limit: limit)
      ensure
        readers.each{_1.close}  if readers
      end
      return count
    end
  end
end
