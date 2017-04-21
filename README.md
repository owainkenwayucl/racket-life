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
╭────────╮
│........│
│...o....│
│.o.o....│
│..oo....│
│........│
│........│
│........│
│........│
╰────────╯
Population: 5

1:
╭────────╮
│........│
│..o.....│
│...oo...│
│..oo....│
│........│
│........│
│........│
│........│
╰────────╯
Population: 5

2:
╭────────╮
│........│
│...o....│
│....o...│
│..ooo...│
│........│
│........│
│........│
│........│
╰────────╯
Population: 5

3:
╭────────╮
│........│
│........│
│..o.o...│
│...oo...│
│...o....│
│........│
│........│
│........│
╰────────╯
Population: 5
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
Step: 0  Population: 5
Writing PBM: glideout00.pbm Done.
Step: 1  Population: 5
Writing PBM: glideout01.pbm Done.
Step: 2  Population: 5
Writing PBM: glideout02.pbm Done.
Step: 3  Population: 5
Writing PBM: glideout03.pbm Done.
Step: 4  Population: 5
Writing PBM: glideout04.pbm Done.
Step: 5  Population: 5
Writing PBM: glideout05.pbm Done.
Step: 6  Population: 5
Writing PBM: glideout06.pbm Done.
Step: 7  Population: 5
Writing PBM: glideout07.pbm Done.
Step: 8  Population: 5
Writing PBM: glideout08.pbm Done.
Step: 9  Population: 5
Writing PBM: glideout09.pbm Done.
Step: 10  Population: 5
Writing PBM: glideout10.pbm Done.
Step: 11  Population: 5
Writing PBM: glideout11.pbm Done.
Step: 12  Population: 5
Writing PBM: glideout12.pbm Done.
Step: 13  Population: 5
Writing PBM: glideout13.pbm Done.
Step: 14  Population: 5
Writing PBM: glideout14.pbm Done.
Step: 15  Population: 5
Writing PBM: glideout15.pbm Done.
Step: 16  Population: 5
Writing PBM: glideout16.pbm Done.
Step: 17  Population: 5
Writing PBM: glideout17.pbm Done.
Step: 18  Population: 5
Writing PBM: glideout18.pbm Done.
Step: 19  Population: 5
Writing PBM: glideout19.pbm Done.
Step: 20  Population: 5
Writing PBM: glideout20.pbm Done.
Step: 21  Population: 5
Writing PBM: glideout21.pbm Done.
Step: 22  Population: 5
Writing PBM: glideout22.pbm Done.
Step: 23  Population: 5
Writing PBM: glideout23.pbm Done.
Step: 24  Population: 5
Writing PBM: glideout24.pbm Done.
Step: 25  Population: 5
Writing PBM: glideout25.pbm Done.
Step: 26  Population: 5
Writing PBM: glideout26.pbm Done.
Step: 27  Population: 5
Writing PBM: glideout27.pbm Done.
Step: 28  Population: 5
Writing PBM: glideout28.pbm Done.
Step: 29  Population: 5
Writing PBM: glideout29.pbm Done.
Step: 30  Population: 5
Writing PBM: glideout30.pbm Done.
Step: 31  Population: 5
Writing PBM: glideout31.pbm Done.
Step: 32  Population: 5
Writing PBM: glideout32.pbm Done.
Step: 33  Population: 5
Writing PBM: glideout33.pbm Done.
$ 
```

You can then use a tool like ImageMagick to convert the frames into an animated gif:

```
$ convert -delay 50 -scale 64x64 glideout*.pbm -loop 0 glider.gif
```

This will produce an animated gif like this:

![example animation](images/glider.gif)


