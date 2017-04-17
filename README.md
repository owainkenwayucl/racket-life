# racket-life
## Conway's Game of Life written in Racket

This is a (fairly bad given this is the first large Racket program I've written) implementation of Conway's Game of Life.

It may be run in two modes - file output (which dumps frames to PBM files) and console output which prints frames to the console.  It reads PBM files as input files.  An example PBM file is shown in `input/glider.pbm`.

## Compiling

To compile the package, enter `make` in the top level directory of the project.

## Console mode

To run the code in console mode, run `life` with two arguments - the input file and the number of steps, so for example:

```
$ ./life input/glider.pbm 3
Reading pbm:

P1
(8 8)
0 0 0 0 0 0 0 0 
0 0 0 1 0 0 0 0 
0 1 0 1 0 0 0 0 
0 0 1 1 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 

Done.
+--------+
|........|
|...o....|
|.o.o....|
|..oo....|
|........|
|........|
|........|
|........|
+--------+

1:
+--------+
|........|
|..o.....|
|...oo...|
|..oo....|
|........|
|........|
|........|
|........|
+--------+

2:
+--------+
|........|
|...o....|
|....o...|
|..ooo...|
|........|
|........|
|........|
|........|
+--------+

3:
+--------+
|........|
|........|
|..o.o...|
|...oo...|
|...o....|
|........|
|........|
|........|
+--------+
$
```

## File mode:

You can invoke file mode by running `life` with three arguments as follows:

```
$ ./life input/glider.pbm 32 glideout
Reading pbm:

P1
(8 8)
0 0 0 0 0 0 0 0 
0 0 0 1 0 0 0 0 
0 1 0 1 0 0 0 0 
0 0 1 1 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 
0 0 0 0 0 0 0 0 

Done.
Writing PBM: glideout00.pbm Done.
Writing PBM: glideout01.pbm Done.
Writing PBM: glideout02.pbm Done.
Writing PBM: glideout03.pbm Done.
Writing PBM: glideout04.pbm Done.
Writing PBM: glideout05.pbm Done.
Writing PBM: glideout06.pbm Done.
Writing PBM: glideout07.pbm Done.
Writing PBM: glideout08.pbm Done.
Writing PBM: glideout09.pbm Done.
Writing PBM: glideout10.pbm Done.
Writing PBM: glideout11.pbm Done.
Writing PBM: glideout12.pbm Done.
Writing PBM: glideout13.pbm Done.
Writing PBM: glideout14.pbm Done.
Writing PBM: glideout15.pbm Done.
Writing PBM: glideout16.pbm Done.
Writing PBM: glideout17.pbm Done.
Writing PBM: glideout18.pbm Done.
Writing PBM: glideout19.pbm Done.
Writing PBM: glideout20.pbm Done.
Writing PBM: glideout21.pbm Done.
Writing PBM: glideout22.pbm Done.
Writing PBM: glideout23.pbm Done.
Writing PBM: glideout24.pbm Done.
Writing PBM: glideout25.pbm Done.
Writing PBM: glideout26.pbm Done.
Writing PBM: glideout27.pbm Done.
Writing PBM: glideout28.pbm Done.
Writing PBM: glideout29.pbm Done.
Writing PBM: glideout30.pbm Done.
Writing PBM: glideout31.pbm Done.
Writing PBM: glideout32.pbm Done.
$ 
```

You can then use a tool like ImageMagick to convert the frames into an animated gif:

```
$ convert -delay 50 -scale 64x64 glideout*.pbm -loop 0 glider.gif
```

This will produce an animated gif like this:

![example animation](images/glider.gif)


