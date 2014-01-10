module SHREDDER

  class Shredder

    attr_reader :shreds, :sewed
    def initialize(options={}, shreds=[], sewed=nil)
      @shreds, @sewed = shreds, sewed
      @shred = options[:shred]
      @relay = options[:relay]
      if @sewed.nil?
        if options[:stream]
          @sewed = (@shred)? STDIN : STDOUT
        else
          @sewed = @shreds.shift
        end
      end
    end

    def execute(sewed=@sewed, shreds=@shreds, shred=@shred)
      stream = false
      if sewed.kind_of?(IO)
        stream = true
        rw     = (shred)? 'w' : 'r'
        shreds = shreds.map{|filename| File.open(filename, rw)}
      end

      shredder = (stream)? Shredder::Streams.new(sewed, shreds) : Shredder::Files.new(sewed, shreds)
      STDOUT.puts STDIN.gets if @relay
      begin
        (shred)? shredder.shred : shredder.sew
      ensure
        shreds.each{|filehandle| filehandle.close} if stream
      end
    end

    def shred(sewed, *shreds)
      execute(sewed, shreds, true)
    end

    def sew(sewed, *shreds)
      execute(sewed, shreds, false)
    end

  end

end
