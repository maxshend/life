# Life

![CI](https://github.com/maxshend/life/actions/workflows/ci.yml/badge.svg)
[![Test Coverage](https://codecov.io/gh/maxshend/life/graph/badge.svg)](https://codecov.io/gh/maxshend/life)

Conway's Game Of Life in Ruby. CLI application with ability to import initial grid state from a CSV file and export output to a GIF image.

## Options
**life start** is used to run the application.

The following options control how the application is run:

***-w, --width*** - grid width

***-h, --height*** - grid height

***-i, --input*** - path to a CSV input file

***-e, --export*** - export to a GIF image

***-n, --iterations*** - number of iterations in the GIF image

## Examples
```
life start -w 25 -h 20
```
![Tux, the Linux mascot](/.github/assets/life_cli.gif)
---

```
life start -w 15 -h 15 -e -n 10
```
![Tux, the Linux mascot](/.github/assets/life.gif)
