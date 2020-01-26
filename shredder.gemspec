Gem::Specification.new do |s|

  s.name     = 'shredder'
  s.version  = '2.0.200126'

  s.homepage = 'https://github.com/carlosjhr64/shredder'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2020-01-26'
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
  s.add_runtime_dependency 'help_parser', '~> 6.5', '>= 6.5.0'
  s.requirements << 'ruby: ruby 2.7.0p0 (2019-12-25 revision 647ee6f091) [x86_64-linux]'

end
