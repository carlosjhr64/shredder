# Standard Libraries
require 'stringio'

# Gems
require 'test/unit'
begin
  require 'symmetric_gpg'
  GPG = true
rescue
  STDERR.puts "Warning: symmetric_gpg not available for testing"
  GPG = false
end

# This Gem
require 'shredder'
include SHREDDER

module TestFunction
  extend Functions
end

class TestShredder < Test::Unit::TestCase

  def test_version
    assert_equal '1.0.0', VERSION
    assert_equal '1.0.0', SHREDDER::VERSION
  end

  def test_functions_even
    abc  = "abcdefghijklmnopqrstuvwxyz"
    string = StringIO.new(abc)
    shred1 = StringIO.new
    shred2 = StringIO.new
    TestFunction.shred(string, [shred1, shred2])
    string.rewind
    shred1.rewind
    shred2.rewind
    l0, l1, l2 = string.length, shred1.length, shred2.length
    assert_equal(l0, l1 + l2)
    assert_equal(l1, l2)
    sewed  = StringIO.new
    TestFunction.sew(sewed, [shred1, shred2])
    sewed.rewind
    assert_equal(sewed.read, abc)

    # Note that the xor starts it's seed with the first letter,
    # so that 'a' in the abc string remains unchanged.
    # Anyways, the point of the following is to show that the shreds
    # are no longer easily recognizable as part of the original string.

    shred1.rewind
    shred = shred1.read
    assert_nil(shred=~/[b-z]/)

    shred2.rewind
    shred = shred2.read
    assert_nil(shred=~/[b-z]/)
  end

  def test_functions_odd
    abc  = "abcdefghijklmnopqrstuvwxyz+"
    string = StringIO.new(abc)
    shred1 = StringIO.new
    shred2 = StringIO.new
    TestFunction.shred(string, [shred1, shred2])
    string.rewind
    shred1.rewind
    shred2.rewind
    l0, l1, l2 = string.length, shred1.length, shred2.length
    assert_equal(l0, l1 + l2)
    assert_equal(l1, l2+1)
    sewed  = StringIO.new
    TestFunction.sew(sewed, [shred1, shred2])
    sewed.rewind
    assert_equal(sewed.read, abc)
  end

  def test_functions_three
    abc  = "abcdefghijklmnopqrstuvwxyz"
    string = StringIO.new(abc)
    shred1 = StringIO.new
    shred2 = StringIO.new
    shred3 = StringIO.new
    TestFunction.shred(string, [shred1, shred2, shred3])
    string.rewind
    shred1.rewind
    shred2.rewind
    shred3.rewind
    l0, l1, l2, l3 = string.length, shred1.length, shred2.length, shred3.length
    assert_equal(l0, l1 + l2 + l3)
    assert(l1>7)
    assert(l2>7)
    assert(l3>7)
    sewed  = StringIO.new
    TestFunction.sew(sewed, [shred1, shred2, shred3])
    sewed.rewind
    assert_equal(sewed.read, abc)
  end

  # Most of the code is tested under cucumber.
  # Just going to test an untested path.
  # Shredder.new(...).execute is well tested.
  # Now test Shredder.new.shred and #sew
  def test_shredder
    system('rm ./temp.* 2> /dev/null')
    refute File.exist? './temp.sewed' # just a quick sanity check
    system('openssl rand -base64 32 > ./temp.txt')
    shredder = Shredder.new
    # ...and just for something a bit different, 4 shreds.
    shredder.shred('./temp.txt', './temp.1', './temp.2', './temp.3', './temp.4')
    assert File.exist? './temp.1'
    assert File.exist? './temp.2'
    assert File.exist? './temp.3'
    assert File.exist? './temp.4'
    shredder.sew('./temp.sewed', './temp.1', './temp.2', './temp.3', './temp.4')
    assert File.exist? './temp.sewed'
    # The following will show the two files to be equal
    assert system 'diff ./temp.txt ./temp.sewed 2> /dev/null'

    system('rm ./temp.*') # cleanup after ourselves
  end

  def test_symmetric_gpg
    if GPG
      system('rm ./temp.* 2> /dev/null')
      string = "A is for Apple."
      shreds = SymmetricGPG::Shreds.new("Shreddelicious!", string, ['./temp.1','./temp.2'])
      shreds.shredder = '/usr/local/bin/ruby -I ./lib ./bin/shredder'
      shreds.shred # Should encrypt and then shred the string into shred.1 and shred.2.
      assert File.exist? './temp.1'
      assert File.exist? './temp.2'
      shreds.plain = nil # no cheat!
      plain = shreds.sew # should get the shredded string back.
      assert_equal string, plain
      # Cleanup after ourselves
      system('rm ./temp.* 2> /dev/null')
    end
  end

end
