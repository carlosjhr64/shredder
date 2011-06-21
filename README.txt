### SYNOPSIS ###

require 'shredder'

# Shreds text.txt into test.f.1, test.f.2, test.f.3
Shredder::Files.new('test.txt', ['test.f.1','test.f.2','test.f.3'] ).shred

# Sews test.f.1, test.f.2, test.f.3 into restored.f.txt
Shredder::Files.new('restored.f.txt', ['test.f.1','test.f.2','test.f.3'] ).sew

# or #

# shred streams #
reader = File.open('test.txt','r')
writers = []; ['test.s.1','test.s.2','test.s.3'].each{|writer| writers.push(File.open(writer,'wb'))}
Shredder::Streams.new(reader,writers).shred
reader.close
writers.each{|writer| writer.close}

# sew streams
writer = File.open('restored.s.txt','wb')
readers = []; ['test.s.1','test.s.2','test.s.3'].each{|writer| readers.push(File.open(writer,'r'))}
Shredder::Streams.new(writer,readers).sew
writer.close
readers.each{|reader| reader.close}

# Also available, Shredder.shred( writer, readers) and Shredder.sew( reader, writers )
# and a command line utility, shredder (run shredder --help for more info).
