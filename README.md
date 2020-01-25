# shredder

[VERSION 2.0.200125](https://github.com/carlosjhr64/shredder/releases)
[github](https://github.com/carlosjhr64/shredder)
[rubygems](https://rubygems.org/gems/shredder)

## DESCRIPTION:

Shred a file into file fragments, and join fragments back into a restored file.

Disperse file shreds in separate depositories
so that no one depository has the entire file.

## SYNOPSIS

Command line:

    $ shredder --help
    $ shredder --version
    $ shredder shred file.1 file.2 < file.orig
    $ shredder sew file.1 file.2 > file.sewed

Library:

    require 'shredder'
    # ...
    shredder = SHREDDER:Shredder.new
    shredder.shred('orinal.txt', 'shred.1', 'shred.2')
    shredder.sew(  'sewed.txt',  'shred.1', 'shred.2')

## INSTALL:

    $ sudo gem install shredder

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
