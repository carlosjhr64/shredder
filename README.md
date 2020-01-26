# shredder

[VERSION 2.0.200125](https://github.com/carlosjhr64/shredder/releases)
[github](https://github.com/carlosjhr64/shredder)
[rubygems](https://rubygems.org/gems/shredder)

## DESCRIPTION:

Shred a file into file fragments, and join fragments back into a restored file.

## SYNOPSIS

### Command line:

    $ shredder --help      # or -h
    $ shredder --version   # or -v
    $ shredder shred file.1 file.2 < file.orig
    $ shredder sew file.1 file.2 > file.sewed

### Library:

    require 'shredder'

#### module Shredder

    require 'stringio'

    sewn = StringIO.new("This is a test String: 1, 2, 3.")
    sewn.string.length #=> 31

    shreds = [StringIO.new, StringIO.new]
    Shredder.shred sewn, shreds #=> 31

    shreds[0].string
    #=> "T\u0001S\u001AAT\u0016T'\e\t\u001A\u001D\u0012\f\u001D"
    shreds[0].string.length #=> 16

    shreds[1].string
    #=> "<\u001AISA\u0011\as\u0006\a]\u0011\f\u001E\u0013"
    shreds[1].string.length #=> 15

    shreds.each{|_|_.rewind}
    restored = StringIO.new
    Shredder.sew shreds, restored

    restored.string #=> "This is a test String: 1, 2, 3."

#### Shredder::Files

    sewn = './tmp/sewn.txt'
    shreds = './tmp/shreds'
    restored  = './tmp/restored.txt'

    File.read(sewn).chomp #=> "This is a test file: 1, 2, 3."
    File.size(sewn) #=> 30

    shredder = Shredder::Files.new(sewn, shreds, 3)
    shredder.shreds
    #=> ["./tmp/shreds.1", "./tmp/shreds.2", "./tmp/shreds.3"]
    shredder.shred #=> 30

    File.read(shreds+'.1') #=> "T\u001A\u001AA\u0016F\t\u0011\u0012\u0013"
    File.read(shreds+'.2') #=> "<SST\a\u000F_\u001D\u001E\u001D"
    File.read(shreds+'.3') #=> "\u0001IA\u0011T\u0005\u001A\f\f$"
    File.size(shreds+'.3') #=> 10

    shredder = Shredder::Files.new(restored, shreds, 3)
    shredder.sewn #=> "./tmp/restored.txt"
    shredder.sew #=> 30
    File.read(restored).chomp #=> "This is a test file: 1, 2, 3."

## INSTALL:

    $ gem install shredder

## LICENSE:

(The MIT License)

Copyright (c) 2020 CarlosJHR64

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
