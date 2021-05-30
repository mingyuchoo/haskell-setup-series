# tutorial-template

## How to build

```bash
$ mkdir <project>
$ cd <project>
$ cabal init

...


$ cabal install —only-dependencies
$ cabal update
$ cabal configure
$ cabal check
$ cabal build
$ cabal run
$ cabal sdist
$ cabal upload
$ cabal install
```

## How to test

### doctest

```bash
$ cd ./app
$ doctest ./Main.hs
```
