require 'shredder'
include Shedder

# IRB Tools
require 'irbtools/configure'
_ = Shredder::VERSION.split('.')[0..1].join('.')
Irbtools.welcome_message = "### Shredder(#{_}) ###"
require 'irbtools'
IRB.conf[:PROMPT][:Shredder] = {
  PROMPT_I:    '> ',
  PROMPT_N:    '| ',
  PROMPT_C:    '| ',
  PROMPT_S:    '| ',
  RETURN:      "=> %s \n",
  AUTO_INDENT: true,
}
IRB.conf[:PROMPT_MODE] = :Shredder
