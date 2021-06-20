# tutorial-template

## Prerequisite

```bash
$ cabal install doctest
$ cabal install hlint
$ cabal install hindent
$ cabal install apply-refact
```

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

## How to pretty format

```bash
$ hindent ./**/*.hs
```

## How to test

### doctest

```bash
$ cd ./app
$ doctest ./Main.hs
```
