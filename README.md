# xflamp

Tiny ruby program which turns on a lamp through a raspberry pi's gpio and a
digital relay when one or more of the configured builds are not passing.

Currently only [travis-ci.org](https://travis-ci.org/) builds are supported out
of the box, however, pull requests for any other build servers are very
welcome. :wink:

## Usage

If you are happy with writing to `PIN 1` and have setup your config file in the
current direcory, then you can start the program with

	$ xflamp

If you want to use another `PIN` or want to specify the config file yourself,
the CLI has some documentation on how to achieve that

```bash
$ xflamp --help
Usage: xflamp [options]
    -p, --pin [PIN]            Pin to write to when there is a non passing build
    -c, --config [CONFIG]      Config file to use
```

## Contributing

1. Fork it ( https://github.com/flower-pot/xflamp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
