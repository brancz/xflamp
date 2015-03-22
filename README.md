[![Build Status](https://travis-ci.org/flower-pot/xflamp.svg?branch=master)](https://travis-ci.org/flower-pot/xflamp)
[![Coverage Status](https://coveralls.io/repos/flower-pot/xflamp/badge.svg?branch=master)](https://coveralls.io/r/flower-pot/xflamp?branch=master)
[![Code Climate](https://codeclimate.com/github/flower-pot/xflamp/badges/gpa.svg)](https://codeclimate.com/github/flower-pot/xflamp)

# xflamp

Tiny ruby program which turns on a lamp through a raspberry pi's gpio and a
digital relay when one or more of the configured builds are not passing.

Currently only [travis-ci.org](https://travis-ci.org/) builds are supported out
of the box, however, pull requests for any other build servers are very
welcome. :wink:

The CLI infrastructure is heavily inspired and blatantly copied from
[travis.rb](https://github.com/travis-ci/travis.rb). (part of my goal was to
use very few dependencies)

## Usage

In general the cli is self documenting

```bash
$ xflamp 
Usage: xflamp COMMAND ...

Available commands:

  config                 configure the builds to watch
  help                   print help info
  version                print version info
  watch                  watch the configured builds

run `xflamp help COMMAND` for more infos
```

### Watch

If you are happy with writing to `PIN 0` and have setup your config file in the
current direcory, then you can start the program with

	$ xflamp watch

If you want to use another `PIN` or want to specify the config file yourself,
the CLI has some documentation on how to achieve that

```bash
$ xflamp watch --help
Watch the configured builds.

Usage: xflamp watch [OPTIONS]
    -h, --help                       display help
    -c, --config-path [CONFIG]       config file to use
    -p, --pin [PIN]                  Pin to write io to
    -o, --once                       Only request the build status once
```

### Config

Example config file (by default called `xflamp.yml` in the current directory)

```yaml
---
servers:
  travis-ci-org:
    projects:
    - flower-pot/xflamp

```

You can generate such a configuration file with the `config` command. It will
ask you for your travis ci authentication token (which will not be saved) to
retrieve your active repos on travis ci. Then you can select the repos you want
to watch interactively.

> see [here](https://github.com/travis-ci/travis.rb#token) on how to get your
> travis token

	$ xflamp config

## Contributing

1. Fork it ( https://github.com/flower-pot/xflamp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
