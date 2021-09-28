module Shredder
  attr_accessor :sewn, :shreds

  # note that these are streams
  def shred(sewn=(@sewn or $stdin), shreds=@shreds,
            writers: shreds, reader: sewn, limit: 0, xor: 0)
    shreds,count = writers.length,0
    while byte = reader.getbyte do
      writers[count%shreds].putc(xor^(xor=byte))
      count += 1 # note that 0 is skipped
      break if count == limit
    end
    return count
  end

  # note that these are streams
  def sew(shreds=@shreds, sewn=(@sewn or $stdout),
          readers: shreds, writer: sewn, limit: 0, xor: 0)
    shreds,count = readers.length,0
    while byte = readers[count%shreds].getbyte do
      writer.putc(xor=(byte^xor))
      count += 1 # note that 0 is skipped
      break if count == limit
    end
    return count
  end

  def shred_files(b=nil, m=2, basename: b, n: m)
    case basename
    when Array
      basename
    when String
      (1..n).map{|i| "#{basename}.#{i}"}
    when Integer
      (1..basename).map{|i| "#{@sewn or 'shred'}.#{i}"}
    else
      raise "Expected basename Array|String|Integer"
    end
  end
end
