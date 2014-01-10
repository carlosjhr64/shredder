Gem::Specification.new do |s|

  s.name     = 'shredder'
  s.version  = '1.0.0'

  s.homepage = 'https://github.com/carlosjhr64/shredder'

  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2014-01-10'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Shred a file into file fragments, and join fragments back into a restored file.

Disperse file shreds in separate depositories
so that no one depository has the entire file.
DESCRIPTION

  s.summary = <<SUMMARY
Shred a file into file fragments, and join fragments back into a restored file.
SUMMARY

  s.extra_rdoc_files = ['README.rdoc']
  s.rdoc_options     = ["--main", "README.rdoc"]

  s.require_paths = ["lib"]
  s.files = %w(
README.rdoc
TODO.txt
bin/shredder
lib/shredder.rb
lib/shredder/files.rb
lib/shredder/functions.rb
lib/shredder/shredder.rb
lib/shredder/streams.rb
lib/shredder/version.rb
shredder.gemspec
  )
  s.executables << 'shredder'
  s.add_runtime_dependency 'help_parser', '~> 1.1', '>= 1.1.0'
  s.requirements << 'ruby: ruby 2.1.0p0 (2013-12-25 revision 44422) [x86_64-linux]'

end
