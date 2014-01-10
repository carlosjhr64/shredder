module SHREDDER

  module Functions

    # note that these are streams
    def shred(reader, writers, limit=0)
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
    def sew(writer, readers, limit=0)
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

  end

end
