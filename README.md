# MandalaCreator

A mandala generator written in Processing.

![Five frames from one run on a black background. A small ring of green and yellow dots in the first frame grows into a dense circular pattern of overlapping green, yellow and pink spiral arms by the last frame.](docs/frames.jpg)

## What this is

A mandala is a circular pattern with rotational symmetry: the same shape repeats as you turn around the centre. This project draws one with Processing, a free tool for writing programs that make pictures.

Every dot the sketch places is copied sixteen times around the centre of the canvas, so any mark becomes a symmetric figure. There are two sketches. In `mandala.pde` you draw with the mouse. In `mandala3D.pde` the program draws a spiral by itself, and the figure opens out as two parameters drift apart.

## What you can learn from it

- How rotational symmetry works, and how 2 to the power `order` sets the number of copies (Mathematics, Art and Design).
- How polar coordinates (a distance and an angle) describe a spiral, and how to turn them into x and y with cosine and sine (Mathematics).
- How a program runs a loop once per frame and builds up a picture over time (Computer Science).
- How a translate and a rotate move the drawing origin, so the same drawing code lands in a new place (Computer Science).
- How keyboard and mouse events make a program interactive (Computer Science).

## Run it

### On your own computer

**You will need:** [Processing](https://processing.org/download). The code uses only the core Processing language, with no extra libraries, so Processing 3 or 4 should run it. This has not been tested on a specific version or operating system.

Processing treats every `.pde` file in a folder as one program. The `mandala` folder holds two complete sketches, and they define the same variables and functions, so they clash if you open them together. Run each one from its own folder:

1. On the repository page, choose **Code**, then **Download ZIP**, and unzip it.
2. Make a new folder next to `mandala` called `mandala3D`.
3. Move **mandala3D.pde** from `mandala` into `mandala3D`.
4. Open Processing. Choose **File**, then **Open**, and pick **mandala/mandala.pde** for the mouse sketch or **mandala3D/mandala3D.pde** for the automatic spiral.
5. Press the **Run** button (the triangle at the top left).

A 1400 by 1400 pixel black window opens. With `mandala3D.pde`, a spiral of coloured dots starts to grow from the centre. With `mandala.pde`, the window stays black until you drag the mouse.

Both sketches save a PNG image into a `GifPhotos` folder every twenty frames. At 60 frames a second that is three images a second, each up to about half a megabyte, so stop the sketch when you have what you want.

### Controls

| Input | What it does |
|---|---|
| Drag the mouse | Places a dot at the pointer and fifteen copies around the centre |
| `r` | Colour red |
| `b` | Colour blue |
| `g` | Colour green |
| `p` | Colour pink |
| `y` | Colour yellow |
| `l` | Colour light blue |
| `w` | Colour white |
| `s` | Saves the current frame as an image |

The colour keys change the colour for a moment only. Every three frames the sketch picks a new colour at random.

## How it works

At the start, the sketch works out an angle of `2 * PI / pow(2, order)`. With `order = 4` that is one sixteenth of a full turn. To place a dot, it moves the origin to the centre of the canvas, then rotates by that angle sixteen times and draws the dot once after each turn. One dot becomes sixteen.

In `mandala3D.pde`, the dot position comes from a spiral. A counter called `value` grows each frame. The distance from the centre is `a + b * value` and the angle is `value`. Cosine and sine turn that distance and angle into x and y. Because `b` changes every frame, the spiral never quite repeats.

| File or folder | What is in it |
|---|---|
| `mandala/mandala.pde` | The mouse-drawing sketch |
| `mandala/mandala3D.pde` | The automatic spiral sketch, with a comment on every line |
| `mandala/GifPhotos/` | Frames saved from one run, one every twenty frames |
| `docs/frames.jpg` | Five of those frames side by side, used in this README |

## Ideas to try

1. Change the number of copies. In `mandala3D.pde`, set `order` to 3 for eight copies or 5 for thirty-two.
2. Change the dot size. In `placeEllipse` in `mandala3D.pde`, change the two `4`s in the `ellipse` call.
3. Use all five colours. In `getNextColor`, `random(1,4)` only ever returns 1, 2 or 3, so red and light blue never appear. Change it to `random(0, colors.length)`.
4. Stop the automatic saving. Put `//` in front of the `saveFrame("GifPhotos/...")` line in either file.
5. Make the colour keys stick. In `mandala.pde`, the `getNextColor` call in `draw` replaces the colour every three frames. Remove it, or add a key that turns random colours on and off.
6. Make it truly 3D. `mandala3D.pde` calls `rotateX` and `rotateY`, which need a 3D renderer. Change `size(1400,1400)` to `size(1400,1400,P3D)` and see what changes.

## Technical details

The rotation per step is `2 * PI / pow(2, order)`, with `order = 4`, so sixteen copies of every mark land around the circle. Two parameters, `a` and `b`, control the shape. They start close together at 2.5 and 2.4. `b` changes by 0.01 every frame and reverses direction at -2.4 and 2.4 (the step size is `incrVal`), so the ratio between `a` and `b` drifts and the figure opens out instead of closing on itself.

That drift is the whole design. A fixed ratio gives one static rosette. A moving one gives the sequence in the image above, and the frames in `mandala/GifPhotos/` are one run sampled every twenty frames.

In `mandala.pde`, the spiral lines in `draw` are commented out, so that sketch only draws where you drag. `setup` in both files draws sixteen guide lines in black, which do not show on the black background.

Canvas is 1400 by 1400. Change `order` for a different number of symmetries and `incrVal` for how fast the figure opens.

## Project status

The sketches are small experiments and have no tests. Known problems:

- The two sketches share a folder and clash in Processing. See the run steps above.
- `mandala3D.pde` calls `rotateX` and `rotateY`, but `size` does not ask for the P3D renderer. These calls need a 3D renderer, so the 3D rotation is unlikely to take effect. This was read from the code and not tested.
- The colour picker only uses three of the five colours in the palette.
- Frames are saved to disk all the time while a sketch runs.

## Licence

You can use, copy and change this code for any purpose, as long as you keep the copyright notice. See [LICENSE](LICENSE) (MIT).

## Credits

Written by Abhishek Shivakumar. Built with [Processing](https://processing.org/). To cite this work, see [CITATION.cff](CITATION.cff).
