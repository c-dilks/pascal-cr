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

Build by running:
```bash
./build.cr                        # standard build
./build.cr --release              # optimized build
crystal run src/run.cr -- [args]  # build and run `pascal` with args (for devs)
```

To generate triangles, run:
```bash
./pascal
```
