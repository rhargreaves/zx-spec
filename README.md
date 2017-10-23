# ZX Spec [![Build Status](https://travis-ci.org/rhargreaves/zx-spec.svg?branch=master)](https://travis-ci.org/rhargreaves/zx-spec)
A framework for test-driving assembly code for the Sinclair ZX Spectrum 48k. This is a **Work In Progress**. The API is not stable at present.

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
            assert_a_equal 5

spec_end
```

### Names and Groupings

You can optionally name a set of asserts using the `it` macro. This groups the asserts into a single test. In addition to `it`, you can use the `describe` macro to group one or more tests. Nested `describe` or `it` macros are not permitted.

### Hexadecimals

By default, expected and actual values are displayed as decimals. You can switch to hexadecimal by defining `display_numbers_as_hex` as non-zero either on the command-line of Pasmo (`--equ display_numbers_as_hex`), or in code before you call `spec_init`:

```
    display_numbers_as_hex    equ    $FF
```

See [test/test-hex.asm](test/test-hex.asm) for example usage. Note that `assert_bytes_equal` always displays expected/actual bytes as a comma-seperated list of hexadecimal pairs, regardless of this setting.

<p align="center">
    <img src="https://github.com/rhargreaves/zx-spec/raw/master/docs/hex.png" width="600" />
</p>

## Assertions

See [test/test-passes.asm](test/test-passes.asm) for examples.

You can immediately pass or fail a test by using:

* `assert_pass`
* `assert_fail`

### Registers

These assertions will preserve register values.

#### 8-bit

* `assert_a_equal`
* `assert_a_not_equal`
* `assert_b_equal`
* `assert_b_not_equal`
* `assert_c_equal`
* `assert_c_not_equal`
* `assert_d_equal`
* `assert_d_not_equal`
* `assert_e_equal`
* `assert_e_not_equal`
* `assert_h_equal`
* `assert_h_not_equal`
* `assert_l_equal`
* `assert_l_not_equal`
* `assert_a_is_zero`
* `assert_a_is_not_zero`

#### 16-bit

* `assert_bc_equal`
* `assert_bc_not_equal`
* `assert_de_equal`
* `assert_de_not_equal`
* `assert_hl_equal`
* `assert_hl_not_equal`
* `assert_ix_equal`
* `assert_ix_not_equal`

##### IY

Asserting on the IY register value is not currently supported. The IY register is used by Spectrum ROM routines as a index to system variables and is not generally recommended to be used in custom routines due to the added complexity of ensuring its use does not interfere with normal operation.

#### Flags

* `assert_z_set`
* `assert_z_reset`
* `assert_carry_set`
* `assert_carry_reset`
* `assert_s_set`
* `assert_s_reset`
* `assert_p_v_set`
* `assert_p_v_reset`

### Memory

Be warned that these assertions will not preserve register values.

#### Single-Byte

* `assert_byte_equal`
* `assert_byte_not_equal`

#### Double-Byte Word

* `assert_word_equal`
* `assert_word_not_equal`

#### Strings

* `assert_str_equal`
* `assert_str_not_equal`

#### Multiple Bytes

* `assert_bytes_equal`
* `assert_bytes_not_equal`

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

### When there's a mixture...

```
$ make demo-mix
```

<p align="center">
    <img src="https://github.com/rhargreaves/zx-spec/raw/master/docs/red.png" width="600" />
</p>

## Credits

* This project was inspired by [64spec](http://64bites.com/64spec/) - a Commodore 64 Testing Framework
