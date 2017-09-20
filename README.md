# ZX-Spec
TDD Framework for the ZX Spectrum (Work In Progress)

![screenshot](https://github.com/rhargreaves/zx-spec/raw/master/docs/initial.png "Screenshot")

## Dependencies

1. Install Docker
2. Install Fuse Emulator
    
    **Linux**

    ```
    $ sudo apt-get install fuse-emulator-common spectrum-roms
    ```
    
    **macOS**
    
    ```
    $ brew install homebrew/games/fuse-emulator
    ```

3. Compile bas2tap

    ```
    $ git submodule update --init
    $ cd bas2tap
    $ make
    ```

## Compile

```
$ make
```

## Run

```
$ make run
```
