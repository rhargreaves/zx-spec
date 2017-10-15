# ZX Spec [![Build Status](https://travis-ci.org/rhargreaves/zx-spec.svg?branch=master)](https://travis-ci.org/rhargreaves/zx-spec)
A TDD framework for the ZX Spectrum. This is a **Work In Progress**. The API is not stable at present.

<p align="center">
    <img src="https://github.com/rhargreaves/zx-spec/raw/master/docs/green.png" width="600" />
</p>

## Usage

The framework has been written with the [Pasmo assembler](http://pasmo.speccy.org/pasmodoc.html). It could well work with other assemblers although I've not tried it.

```asm
include src/zx-spec.asm

spec_init
    
    describe 'ld a,n'
        it 'sets A register to value'
            ld a,5
            assert_a_equals 5

spec_end
```

### Names and Groupings

You can optionally name a set of asserts using the `it` macro. This groups the asserts into a single test. In addition to `it`, you can use the `describe` macro to group one or more tests. Nested `describe` or `it` macros are not permitted.

### Assertions

Currently you can only assert on register values, although I plan to add memory-based assertions too.

See [test/test-passes.asm](test/test-passes.asm) for example usages.

* `assert_a_equals`
* `assert_a_not_equals`
* `assert_b_equals`
* `assert_b_not_equals`
* `assert_c_equals`
* `assert_c_not_equals`
* `assert_d_equals`
* `assert_d_not_equals`
* `assert_e_equals`
* `assert_e_not_equals`
* `assert_h_equals`
* `assert_h_not_equals`
* `assert_l_equals`
* `assert_l_not_equals`
* `assert_a_is_zero`
* `assert_a_is_not_zero`
* `assert_fail`
* `assert_pass`

## Dependencies

* Python 2.7 (for running ZX Spec tests)
* Docker (for running Pasmo)
* Fuse Emulator
    
    **Linux**

    ```sh
    $ sudo apt-get install fuse-emulator-common spectrum-roms
    ```
    
    **macOS**
    
    ```sh
    $ brew install homebrew/games/fuse-emulator
    ```
    
    You can also run [Fuse with Docker](https://github.com/rhargreaves/fuse-emulator-docker/blob/master/run-fuse.sh) by setting the `FUSE` environment variable accordingly:
    
    ```sh
    $ export "FUSE=docker run -v /tmp/.X11-unix:/tmp/.X11-unix --privileged -e DISPLAY=unix$DISPLAY -it rhargreaves/fuse-emulator"
    ```

## Tests

ZX Spec can be tested by running:

```
$ make test
```

Two sets of automated tests will run. One set results in all tests passing, and the other set results in all tests failing. The results are sent to an emulated ZX Printer (rather than sent to the display) which is then output by the emulator to a text file. This file is then validated to ensure the framework is working correctly.

## Demos

You can run a couple of example demos:

### When all tests pass...

```
$ make demo-green
```

### When all tests fail...

```
$ make demo-red
```

<p align="center">
    <img src="https://github.com/rhargreaves/zx-spec/raw/master/docs/red-1.png" width="600" />
</p>

Scroll...

<p align="center">
    <img src="https://github.com/rhargreaves/zx-spec/raw/master/docs/red-2.png" width="600" />
</p>

## Credits

* This project was inspired by [64spec](http://64bites.com/64spec/) - a Commodore 64 Testing Framework
