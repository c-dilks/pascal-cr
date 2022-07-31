# Mathographix

A collection of functions that map mathematical objects to visuals. For example, a Pascal
triangle modulo a fixed number:

![pascal](/img/sample.png)

This is an update and generalization of the [Perl Pascal triangle generator](https://github.com/c-dilks/pascal),
with the goal to reproduce [images like these](https://github.com/c-dilks/pascal/tree/master/img)
much more efficiently.

## Building
Both Ruby and Crystal are required. Additional dependencies can be installed with `bundle` and `shards`:
```bash
bundle install   # install ruby gems
shards install   # install crystal shards
```

Build by running one of the following:
```bash
./build.rb             # standard build
./build.rb --release   # optimized build
```

## Usage
To generate triangles, run:
```bash
./math      # run with default options
./math -h   # show usage guide
```
View output SVG files in a browser, or Eye of GNOME (`eog`), for example

If you edit the code, you can re-build and re-run with a single command:
```bash
crystal run src/app.cr -- [args]   # `[args]` will be passed to `math`
```
