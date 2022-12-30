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
  s.add_runtime_dependency 'help_parser', '~> 8.1', '>= 8.1.221206'
  s.requirements << 'ruby: ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [aarch64-linux]'

end
