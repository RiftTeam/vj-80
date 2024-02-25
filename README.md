# VJ-80

TIC-80 VJing Tool.

## Overview

VJ-80 collects together a range of visual effects, some of which are sound-responsive.  
These effects can be cued live, to add visuals to music.

The TIC-80 has two VBANKs which become the screen content - the back bank is the Effect and the front bank is the Overlay. Both of these VBANKs have an optional Modifier.

The `vj-80.tic` file should be run on the [FFT build of the TIC-80](https://github.com/glastonbridge/TIC-80). The regular version will provide some fake FFT values, but they aren't currently realistic.

A configuration file sets up which effects, overlays, modifiers, palettes, and shortcuts are set up, so this can be customised for each gig.

## Control

There are a lot of keyboard controls! Start TIC-80, load the .tic file, and start some music or other sound playing on your computer, before trying the following:

### Shortcuts

`SHIFT + 1` to `SHIFT + 9` will trigger any preset combinations in the configuration.

`TAB` - toggles the on-screen effect info. Useful for debug, but also for learning, or if you get in a pickle!

Each line of a QWERTY keyboard controls one of the layers:
- `q - p` is for the back bank (Effect)
- `1 - 8` is for the back modifier
- `a - ;` is for the front bank (Overlay)
- `z - ,` is for the front modifier

| Level | Effect- | Effect+ | Control Var- | Control Var+ | Time Mode- | Time Mode+ | Time- | Time+ | Palette+ | Palette- | Panic Reset |
| ---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Back Modifier | `1` | `2` | `3` | `4` | `5` | `6 ` | `7` | `8` | | | `ALT + 1` |
| Back Bank Effect | `q` | `w` | `e` | `r` | `t` | `y` | `u` | `i` | `o` | `p` | `ALT + q` |
| Front Bank Effect | `a` | `s` | `d` | `f` | `g` | `h` | `j` | `k` | `l` | `;` | `ALT + a` |
| Front Modifier | `z` | `x ` | `c` | `v` | `b` | `n` | `m` | `<` | | | `ALT + z` |

In each line, controls are grouped in 2 keys. 
- The first two keys (i.e. `q` and `w`) will rotate through the various Effects. 
- The next two (i.e. `e` and `r`) change a control variable, different for each option.
- The next two (i.e. `t` and `y`) change the time mode:
	- No time
	- Milliseconds from start
	- Beat
	- Bass (immediate)
	- Bass (sum)
	- Mids (immediate)
	- Mids (sum)
	- Treble (immediate)
	- Treble (sum)
- The next two (i.e. `u` and `i`) divide the time variable. This can go negative.
- The last key pair (i.e. `o` and `p`) change the palettes.
- The `panic reset` sets a layer back to the initial settings.

- `HOME` - Loudness increase (amplify the FFT response)
- `END` - Loudness decrease (reduce the FFT response)
- `SHIFT + HOME` - FFT Window increase [*]
- `SHIFT + END` - FFT Window decrease [*]
- `INSERT` - toggle clear-screen each frame vs no clear (Effect)
- `DELETE` - toggle clear-screen each frame vs no clear (Overlay)
- `SHIFT + INSERT` - Stutter - toggle: clear-screen only on the beat (Effect)
- `SHIFT + DELETE` - Stutter - toggle: clear-screen only on the beat (Overlay)
- `PAGE UP` - toggle the modifier order (add noise to the Effect, or the previous frame)
- `PAGE DOWN` - toggle the modifier order (add noise to the Overlay, or the previous frame)
- `SHIFT + BACKSPACE` - Dump state to Trace

There is no automatic beat detection (that's unlikely to be possible), but pressing `SPACE` four times will change the beat timing, so press it to beat match to the kickdrum of the music.

[*] These change the window of the immediate fft variables. At the start the immediate fft will be about 10 frames. the higher the window, the more the FFT is smoothed.

## Customisation

This project is spread across multiple files to make it customisable, and, since we need to load `lua` files, requires the Pro version of TIC-80 to compile. It is possible to build Pro TIC-80 for free, but it can also be purchased for a low price, which supports the developer.

An external editor is highly recommended for working with large projects, rather than TIC-80's inbuilt one!

The `~/gig/` directory contains some configuration files. One of these should be `require`d from the `vj-80.lua` file. You can copy one of the existing ones to make your own setup.

This file determines which effects/overlays/modifiers/palettes/shortcuts are included.

The FFT version of TIC will not load `lua` files, so we need to compile the code and output them as a `tic` file.

- Bundle into one file. This can be done with the [Rift TIC-80 Bundler](https://github.com/RiftTeam/tic-80-bundler), by calling something like `tic-80-bundler.exe --src path-to-src\vj-80.lua --dest path-to-dest\vj-80-bundled.lua`
- Load the bundled file into Pro TIC-80, then save it as a `tic` file.
- Load that `tic` file into the FFT version of TIC-80.

## Things to Maybe Do

 - Add config for the Madtixx DJ set at Revision
 - Nomenclature around Effect and Overlay to save confusion?
-  Passing FFT values around as units rather than 0-255 might make them easier to reason with in effects.
- Get `fuji_twist` Effect working again.
- Keys when not at a full-size keyboard? (I think) some of the actions (shift+home, page up/down) don't trigger on a shorter keyboard?
- The timing modifier keys feel more important than the control modifier keys... i.e. I feel like switching (E and R) and (T and Y), so the timing modifiers are closer to the effect changer..?
- Sparse documentation for folks to plug in effects/overlays/modifiers/palettes.
- Check ps' snapshot trace thing still works (I'm *sure* it doesn't, but easily fixed)
- Wrap FFT code in an object.
- Make the Customisation instructions better.
- Clamp control vars to the same scale, and make sure we can't do things like make the font size negative (in `text_bounce_up`)
- Fix `text_bounce_up` hack.
- Mouse effects?
- Save to PMEM, so we can resume.