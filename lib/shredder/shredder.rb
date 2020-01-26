module Shredder
  # note that these are streams
  def shred(sewn=(@sewn or $stdin), shreds=@shreds,
            writers: shreds, reader: sewn, limit: 0)
    shreds,xor,count = writers.length,0,0
    while byte = reader.getbyte do
      writers[count%shreds].putc(xor^(xor=byte))
      count += 1 # not that 0 is skipped
      break if count == limit
    end
    return count
  end

  # note that these are streams
  def sew(shreds=@shreds, sewn=(@sewn or $stdout),
          readers: shreds, writer: sewn, limit: 0)
    shreds,xor,count = readers.length,0,0
    while byte = readers[count%shreds].getbyte do
      writer.putc(xor=(byte^xor))
      count += 1 # note that 0 is skipped
      break if count == limit
    end
    return count
  end

  extend self
end
