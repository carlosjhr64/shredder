@main
Feature: Main Features

  Background:
    * Given command "ruby -I ./lib ./bin/shredder"

  Scenario: Long opt version.
    * Given arguments "--version"
    * When run
    * Then status is "0"
    * Then stderr is ""
    * Then stdout is "1.0.0"

  Scenario: Long opt help.
    * Given arguments "--help"
    * When run
    * Then status is "0"
    * Then stderr is ""
    * Then stdout matches "^Usage: shredder"

  Scenario: Can't be both sew and shred.
    * Given system(rm ./temp.* 2> /dev/null)
    * Given system(openssl rand -base64 32 > ./temp.txt)
    * Given arguments "--sew --shred ./temp.txt ./temp.1 ./temp.2"
    * When run
    * Then status is "64"
    * Then stderr is not ""
    * Then stdout is ""
    * Then stderr is "Need choice: sew or shred?"

  Scenario: Needs to be either sew or shred.
    * Given system(rm ./temp.* 2> /dev/null)
    * Given system(openssl rand -base64 32 > ./temp.txt)
    * Given arguments "./temp.txt ./temp.1 ./temp.2"
    * When run
    * Then status is "64"
    * Then stderr is not ""
    * Then stdout is ""
    * Then stderr is "Need choice: sew or shred?"

  Scenario: What we shred, we can sew.
    * Given system(rm ./temp.* 2> /dev/null)
    * Given system(openssl rand -base64 32 > ./temp.txt)
    * Given arguments "--shred ./temp.txt ./temp.1 ./temp.2"
    * When run
    * Then status is "0"
    * Then stderr is ""
    * Then stdout is ""
    * Then system(test -e ./temp.1)
    * Then system(test -e ./temp.2)
    * Given arguments "--sew ./temp.sewed ./temp.1 ./temp.2"
    * When run
    * Then status is "0"
    * Then stderr is ""
    * Then stdout is ""
    * Then system(test -e ./temp.sewed)
    # temp.txt and temp.sewed are equal
    * Then system(diff temp.txt temp.sewed > /dev/null)
    # Just a sanity check temp.1 and temp.2 are not equal
    * Then not system(diff temp.1 temp.2 > /dev/null)

  Scenario: What we shred from stdin, we can sew to stdout.  And using 3 shreds to boot!
    * Given system(rm ./temp.* 2> /dev/null)
    * Given system(openssl rand -base64 32 > ./temp.txt)
    * Given system(cat ./temp.txt | ruby -I ./lib ./bin/shredder --shred --io ./temp.1 ./temp.2 ./temp.3)
    * Then system(test -e ./temp.3)
    * Given system(ruby -I ./lib ./bin/shredder --sew --io ./temp.1 ./temp.2 ./temp.3 > ./temp.sewed)
    * Then system(test -e ./temp.sewed)
    * Then system(diff temp.txt temp.sewed > /dev/null)

    # Let's clean up after ourselves...
    * Given system(rm ./temp.* 2> /dev/null)
