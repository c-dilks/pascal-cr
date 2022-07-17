![pascal](/img/sample.png)

# pascal-cr
Pascal triangle visuals in [Crystal](https://crystal-lang.org/)

This is an update of [the slow Perl version](https://github.com/c-dilks/pascal).
The goal is to reproduce [images like these](https://github.com/c-dilks/pascal/tree/master/img)
much more efficiently.

## Building
Both Ruby and Crystal are required. Additional dependencies can be installed
with `bundle` and `shards`:
```bash
bundle install  # install ruby gems
shards install  # install crystal shards
```

Build by running one of the following:
```bash
./build.rb                        # standard build
./build.rb --release              # optimized build
crystal run src/run.cr -- [args]  # build and run `pascal` with paramters `[args]`
```

## Usage
To generate triangles, run:
```bash
./pascal     # run with default options
./pascal -h  # show usage guide
```
