Gem::Specification.new do |s|

  s.name     = 'shredder'
  s.version  = '3.1.221230'

  s.homepage = 'https://github.com/carlosjhr64/shredder'

  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2022-12-30'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
Shred a file into file fragments, and join fragments back into a restored file.
DESCRIPTION

  s.summary = <<SUMMARY
Shred a file into file fragments, and join fragments back into a restored file.
SUMMARY

  s.require_paths = ['lib']
  s.files = %w(
README.md
bin/shredder
lib/shredder.rb
lib/shredder/files.rb
lib/shredder/shredder.rb
lib/shredder/stdio.rb
lib/shredder/streams.rb
  )
  s.executables << 'shredder'
  s.add_runtime_dependency 'help_parser', '~> 8.0', '>= 8.0.210917'
  s.requirements << 'ruby: ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux]'

end
