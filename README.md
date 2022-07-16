![pascal](/img/sample.png)

# pascal-cr
Pascal triangle visuals in [Crystal](https://crystal-lang.org/)

This is an update of [the slow Perl version](https://github.com/c-dilks/pascal).
The goal is to reproduce [images like these](https://github.com/c-dilks/pascal/tree/master/img)
much more efficiently.

## Usage
Install dependencies:
```bash
shards install
```

Build by running one of the following:
```bash
./build.cr                        # standard build
./build.cr --release              # optimized build
crystal run src/run.cr -- [args]  # build and run `pascal` with paramters `[args]`
```

To generate triangles, run:
```bash
./pascal [NUM_ROWS] [MOD] [SEED]
```
where
- `[NUM_ROWS]` is the number of rows
- `[MODULUS]` is the modulus, where each number `N` is drawn with a color
  representing `N.modulo [MODULUS]`
- `[SEED]` is the number in the first row (typically 1)

The output will be an SVG file, openable in a web browser, for example
