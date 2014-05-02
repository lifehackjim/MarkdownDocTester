Markdown Doc Tester Readme
===========================

---------------------------
Table of contents:

  * [Markdown Doc Tester Usage](#markdown-doc-tester-usage)
  * [Reason for MDT](#reason-for-mdt)
  * [Config Section Definitions](#config-section-definitions)
  * [Section Definitions](#section-definitions)
  * [Examples](#examples)
    * [Adding notes](#adding-notes)
    * [Displaying an example command but not running it](#displaying-an-example-command-but-not-running-it)
    * [Running a command](#running-a-command)
    * [Running a command and checking the exit code is 0](#running-a-command-and-checking-the-exit-code-is-0)
    * [Running a command and checking the exit code is NOT 0](#running-a-command-and-checking-the-exit-code-is-not-0)
    * [Checking that a file exists after running a command](#checking-that-a-file-exists-after-running-a-command)
    * [Checking that a file match is found after running a command](#checking-that-a-file-match-is-found-after-running-a-command)
    * [Checking that a file match is NOT found after running a command](#checking-that-a-file-match-is-not-found-after-running-a-command)
    * [Performing cleanup BEFORE running a command](#performing-cleanup-before-running-a-command)
    * [Creating Content BEFORE running a command](#creating-content-before-running-a-command)
    * [Showing Content AFTER running a command](#showing-content-after-running-a-command)
    * [Invalid test results](#invalid-test-results)
  * [Adding more validtests](#adding-more-validtests)

---------------------------

# Markdown Doc Tester Usage

```bash
md_doctester.py -h
```

```
md_doctester v1.4.4 by Jim Olsen (jim@lifehack.com)
usage: md_doctester.py [-h] -f FILE [-a GITHUB_TOKEN] [-o OUTDIR]
                       [-l [LOGFILE]] [-s] [-c] [-t TITLE] [-v]

Run tests, create markdown and HTML documentation from the test output

Last validated to work with:
- Python 2.7.5

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  The doctest definition file (default: None)
  -a GITHUB_TOKEN, --auth GITHUB_TOKEN
                        Github oauth token (needed if you plan to use the
                        Github API to convert Markdown to HTML more than 60
                        times an hour). (default: )
  -o OUTDIR, --outdir OUTDIR
                        The output directory for the Markdown and HTML files
                        (default: /tmp/2014_05_02-09_35_18)
  -l [LOGFILE], --log [LOGFILE]
                        Save the log to a file (if no file supplied, will be
                        saved to $date.$prog.log) (default: False)
  -s, --skipconvert     Skip Converting the Markdown to GFM (which needs
                        access to https://api.github.com ) (default: False)
  -c, --convertonly     Just convert a markdown file in -f to HTML using
                        github (default: False)
  -t TITLE, --title TITLE
                        Title of HTML document (default: )
  -v, --verbose         Increase console output verbosity (default: None)
```

  * Validation Test: exitcode
    * Valid: **True**
    * Messages: Exit Code is 0

# Reason for MDT

  * [Readme Driven Development](http://tom.preston-werner.com/2010/08/23/readme-driven-development.html)
  * I wanted a quick and simple way to create documentation for the myriad of scripts I write during the course of my work.
  * I wanted documentation in both HTML and markdown format.
  * I also wanted to be able to test my scripts in a consistent manner.

# Config Section Definitions

  * output_blocks: true/false, yes/no - whether to include the output of all 'cmd' definitions in each section, defaults to true
  * valid_blocks: true/false, yes/no - whether to include the output of all 'validtests' definitions in each section, defaults to true
  * TOC: true/false, yes/no - whether to include the a table of contents or not, defaults to true
  * mainheader: string - This is used for the main header of the document - if none supplied there will be no main header
  * basename: string - the basename of the file to generate. if not supplied, will be generated from the basename of the ini file (minus extension)
  * contact: string - contact info to include in generation string at bottom of doc. if not supplied, local unix username will be inserted instead
  * title: string - Title to use for HTML document. if not supplied, will be generated from the basename of the ini file (minus extension)
  * outdir: string - The directory to save this files generated docs. If not supplied, defaults to /tmp/$date (or whatever was supplied on command line)

# Section Definitions

  * notesN - string - a note to include for this section. Multiple notes can be defined, just need to be named differently. Deeper notes can be defined by using notesNN / notesNNN
  * norun - true/false, yes/no - whether to run 'cmd' or not, defaults to true
  * headerdepth - int - the number of #s to put in front of the section header
  * cmd - string - the command to run
  * validtests - string - a comma seperated string of validation tests to run
  * exitcode - int - the exit code to use when running the validation tests 'exitcode' and 'notexitcode'. defaults to 0
  * file_exist - str - the file to check for when running the validation test 'file_exist'
  * filematch - str - the wildcard to check for when running the validation test 'filematch'
  * dirmatch - str - the directory to search for 'filematch' wildcard under when running the validation test 'filematch'
  * precleanup - str - the command to run before running 'cmd'
  * content generation before running 'cmd' definitions:
    * contentfilenameN: string - the filename to generate, where N is a contentid
    * contenttypeN: string - the type of content for filename for contentid N
    * contenttextN: string - the text to put into the filename for contentid N
  * content output after running 'cmd' definitions:
    * afterfilenameN: string - the filename to output, where N is a contentid
    * aftertypeN: string - the type of content for filename for contentid N

# Examples

  * This readme was generated with MDT, for one example.
  * See [example/md_doctester.ini](example/md_doctester.ini) for how this README was generated
  * See [example/build.sh](example/build.sh) for a script that will build markdown and HTML documentation for all *.ini files in example/

## Adding notes

  * Just include a definition that starts with 'notes'
  * You can define multiple notes, they just need to be named differently (but all must start with 'notes')

## Displaying an example command but not running it

  * If you include a definition that contains 'norun: true', the command will not be run, just displayed in a bash code block

```bash
example_command -a -b -c 'FILENAME' -u "$USER"
```

## Running a command

  * Just include a definition 'cmd' with command you wish to run

```bash
uname -a
```

```
Darwin Calabacita.local 13.1.0 Darwin Kernel Version 13.1.0: Wed Apr  2 23:52:02 PDT 2014; root:xnu-2422.92.1~2/RELEASE_X86_64 x86_64
```

## Running a command and checking the exit code is 0

  * If you include a definition 'validtests' and specify 'exitcode' as one of the tests, it will by default check to see if the command exits with an exitcode of 0
  * If you include a definition 'exitcode' and specify an exitcode, it will check for that exit code instead of 0

```bash
python -V
```

```STDERR
Python 2.7.5
```

  * Validation Test: exitcode
    * Valid: **True**
    * Messages: Exit Code is 0

## Running a command and checking the exit code is NOT 0

  * If you include a definition 'validtests' and specify 'notexitcode' as one of the tests, it will by default check to see if the command exits with an exitcode that is NOT 0
  * If you include a definition 'exitcode' and specify an exitcode, it will check for that exit code instead of 0

```bash
python -V
```

```STDERR
Python 2.7.5
```

  * Validation Test: notexitcode
    * Valid: **True**
    * Messages: Exit Code is not 5

## Checking that a file exists after running a command

  * If you include a definition 'validtests' and specify 'file_exist' as one of the tests, it will check that the file defined in 'file_exist' is found after running 'cmd'

```bash
mkdir -p /tmp/foo && echo "this is a test" >> /tmp/foo/test && find /tmp/foo -ls
```

```
87170915        0 drwxr-xr-x    4 jolsen           wheel                 136 May  2 09:35 /tmp/foo
87170947        8 -rw-r--r--    1 jolsen           wheel                  15 May  2 09:35 /tmp/foo/test
87170916        8 -rw-r--r--    1 jolsen           wheel                  19 May  2 09:34 /tmp/foo/test.json
```

  * Validation Test: exitcode
    * Valid: **True**
    * Messages: Exit Code is 0

  * Validation Test: file_exist
    * Valid: **True**
    * Messages: File /tmp/foo/test exists

## Checking that a file match is found after running a command

  * If you include a definition 'validtests' and specify 'filematch' as one of the tests, it will check that the wildcard defined in 'filematch' is found somewhere under the directory defined in 'dirmatch'

```bash
mkdir -p /tmp/foo && echo "this is a test" >> /tmp/foo/test && find /tmp/foo -ls
```

```
87170915        0 drwxr-xr-x    4 jolsen           wheel                 136 May  2 09:35 /tmp/foo
87170947        8 -rw-r--r--    1 jolsen           wheel                  30 May  2 09:35 /tmp/foo/test
87170916        8 -rw-r--r--    1 jolsen           wheel                  19 May  2 09:34 /tmp/foo/test.json
```

  * Validation Test: exitcode
    * Valid: **True**
    * Messages: Exit Code is 0

  * Validation Test: filematch
    * Valid: **True**
    * Messages: File matches found for /tmp/*test*: ['/tmp/foo/test', '/tmp/foo/test.json']

## Checking that a file match is NOT found after running a command

  * If you include a definition 'validtests' and specify 'nofilematch' as one of the tests, it will check that the wildcard defined in 'filematch' is NOT found somewhere under the directory defined in 'dirmatch'

```bash
mkdir -p /tmp/foo && echo "this is a test" >> /tmp/foo/test && find /tmp/foo -ls
```

```
87170915        0 drwxr-xr-x    4 jolsen           wheel                 136 May  2 09:35 /tmp/foo
87170947        8 -rw-r--r--    1 jolsen           wheel                  45 May  2 09:35 /tmp/foo/test
87170916        8 -rw-r--r--    1 jolsen           wheel                  19 May  2 09:34 /tmp/foo/test.json
```

  * Validation Test: exitcode
    * Valid: **True**
    * Messages: Exit Code is 0

  * Validation Test: nofilematch
    * Valid: **True**
    * Messages: No file matches found for /tmp/*test4*

## Performing cleanup BEFORE running a command

  * If you include a definition 'precleanup', the command specified there-in will be run before 'cmd' is run
  * This section has a precleanup with `rm -rf /tmp/foo`

```bash
mkdir -p /tmp/foo && echo "this is a test" >> /tmp/foo/test && find /tmp/foo -ls
```

```
87170948        0 drwxr-xr-x    3 jolsen           wheel                 102 May  2 09:35 /tmp/foo
87170949        8 -rw-r--r--    1 jolsen           wheel                  15 May  2 09:35 /tmp/foo/test
```

  * Validation Test: exitcode
    * Valid: **True**
    * Messages: Exit Code is 0

## Creating Content BEFORE running a command

  * You can create content by defining 'contentfilenameN', 'contenttypeN', and 'contenttextN', where N is the same for each definition. For example:
  * `contentfilename1: /tmp/foo/test.json`
  * `contenttype1: json`
  * `contenttext1: { "test": "blah" }`
  * this would create a file in /tmp/foo/test.json before running 'cmd'. when displaying the content block, contenttype will be added into the code fencing blocks

 * Content File: /tmp/foo/test.json

```json
{
    "test": "blah"
}
```

```bash
find /tmp/foo -ls
```

```
87170950        0 drwxr-xr-x    3 jolsen           wheel                 102 May  2 09:35 /tmp/foo
87170951        8 -rw-r--r--    1 jolsen           wheel                  18 May  2 09:35 /tmp/foo/test.json
```

  * Validation Test: exitcode
    * Valid: **True**
    * Messages: Exit Code is 0

  * Validation Test: file_exist
    * Valid: **True**
    * Messages: File /tmp/foo/test.json exists

## Showing Content AFTER running a command

  * You can show content after a command is run by defining 'afterfilenameN' and 'aftertypeN', and 'contenttextN', where N is the same for each definition. For example:
  * `afterfilename1: /tmp/foo/test.json`
  * `aftertype1: json`
  * This would show the contents of the file/tmp/foo/test.json after running 'cmd'. when displaying the content block, aftertype will be added into the code fencing blocks

```bash
mkdir -p /tmp/foo && echo '{ "test": "blah" }' > /tmp/foo/test.json
```

 * Post-command contents of: /tmp/foo/test.json

```json
{
    "test": "blah"
}
```

  * Validation Test: exitcode
    * Valid: **True**
    * Messages: Exit Code is 0

  * Validation Test: file_exist
    * Valid: **True**
    * Messages: File /tmp/foo/test.json exists

## Invalid test results

  * This is just to show what an invalid test looks like

```bash
ls -l /tmp/foo /does_not_exist
```

```
/tmp/foo:
total 8
-rw-r--r--  1 jolsen  wheel  19 May  2 09:35 test.json
```

```STDERR
ls: /does_not_exist: No such file or directory
```

  * Validation Test: exitcode
    * Valid: **False**
    * Messages: Exit Code is not 0

  * Validation Test: file_exist
    * Valid: **False**
    * Messages: File /does_not_exist does not exist

# Adding more validtests

  * The tests specified in 'validtests' are methods defined in the MDTest class
  * Any test specified just needs to exist as a method that begins with 'val_test_'. The current section is passed into each test method, so adding new definitions that tests rely on is rather easy.

###### generated by: `md_doctester v1.4.4`, date: Fri May  2 09:35:18 2014 EDT, Contact info: **Jim Olsen <jim@lifehack.com>**