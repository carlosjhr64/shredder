require 'open3'

# Requires:
#`bash`

H = {}

def _given(condition)
  case condition
  when /^(\w+) "([^"]*)"$/
    H[$1] = $2
  when /^system\(([^\(\)]*)\)$/
    system($1)
  else
    raise "Unrecognized Given-Statement"
  end
end

def _when(condition)
  case condition
  when 'run'
    command, arguments = H['command'], H['arguments']
    raise 'Need command and argurments to run' unless command and arguments
    stdout, stderr, status = Open3.capture3("#{command} #{arguments}")
    H['status'] = status.exitstatus
    H['stdout'] = stdout.chomp
    H['stderr'] = stderr.chomp
  else
    raise "Unrecognized When-Statement"
  end
end

def _then(condition)
  case condition
  when /^(not )?system\(([^\(\)]*)\)$/
    neg, cmd = $1, $2
    ok = system(cmd)
    ok = !ok if neg
    raise "Sytem Call Error" unless ok
  when /^(\w+) is( not)? "([^"]*)"$/
    key, negate, expected = $1, $2, $3
    actual = H[key].to_s
    ok = (actual == expected)
    ok = !ok if negate
    raise "Got #{actual} for #{key}" unless ok
  when /^(\w+) matches "([^"]*)"$/
    key, expected = $1, Regexp.new($2)
    actual = H[key].to_s
    ok = (actual =~ expected)
    ok = !ok if negate
    raise "Got #{actual} for #{key}" unless ok
  else
    raise "Unrecognized Then-Statement"
  end
end

Given /^(\w+) (.*)$/ do |given, condition|
  condition.strip!
  case given
  when 'Given'
    _given(condition)
  when 'When'
    _when(condition)
  when 'Then'
    _then(condition)
  else
    raise "'#{given}' form not defined."
  end
end
