@main
Feature: Main Features

  Background:
    * Given command "ruby -I ./lib ./bin/shredder"

  Scenario: Long opt version.
    * Given arguments "--version"
    * When run
    * Then status is "0"
    * Then stderr is ""
    * Then stdout is "2.0.200126"

  Scenario: Long opt help.
    * Given arguments "--help"
    * When run
    * Then status is "0"
    * Then stderr is ""
    * Then stdout matches "^Usage:"

  Scenario: What we shred, we can sew.
    * Given system(rm ./tmp/temp.* 2> /dev/null)
    * Given system(openssl rand -base64 32 > ./tmp/temp.orig)
    * Given arguments "shred --n=2 ./tmp/temp < ./tmp/temp.orig"
    * When run
    * Then status is "0"
    * Then stderr is ""
    * Then stdout is ""
    * Then system(test -e ./tmp/temp.1)
    * Then system(test -e ./tmp/temp.2)
    * Given arguments "sew ./tmp/temp.1 ./tmp/temp.2 > ./tmp/temp.restored"
    * When run
    * Then status is "0"
    * Then stderr is ""
    * Then stdout is ""
    * Then system(test -e ./tmp/temp.restored)
    # temp.orig and temp.restored are equal
    * Then system(diff ./tmp/temp.orig ./tmp/temp.restored > /dev/null)
    # Just a sanity check temp.1 and temp.2 are not equal
    * Then not system(diff ./tmp/temp.1 ./tmp/temp.2 > /dev/null)

    # Let's clean up after ourselves...
    * Given system(rm ./tmp/temp.* 2> /dev/null)
