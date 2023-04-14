# vj-80
tic 80 vj'ing tool

This version is pretty much a prototype which needs a lot of refactoring and clean up, but it works. The main idea is that there are 4 layers of visuals, with an effect and "modifier" on both visual banks of the TIC80.
There are a lot of keyboard controls, and there isnt a helpfile yet.. So load the fft build of the TIC80 (), load the .tic file, start some music or other sound playing on your computer and try the following:

shift+1 to shift+4 will give you preset screens. (currently for the madtixx dj set at revision)
each line of a qwerty keyboard will control one of the layers: q-p is for the background bank, 1-8 for the background modifier, a-; for the overlay bank, z-, for the overlay modifier
in each line, controls are grouped in 2 keys. 
  the first two keys (ie, q and w) will rotate through the various options. 
  the next two change a control variable (e and r), different for each option. 
  (t and y) change the time mode: no time, milliseconds from start, beat, bass (immediate), bass (sum), mids (immediate), mids (sum), treble (immediate), treble (sum)
  (u and i) divide the time variable, and you can go negative as well
  for the banks, the last key pair (o and p) change the palettes
pressing space 4 times will change the beat timing, so press it to beat match to the kickdrum of some EDM
insert and delete control clearscreen for the background and overlay layers (so you can see the modifiers)
shift+insert and shift+delete switch on and off the clearscreen per beat
home and end change the amplification of the fft input
shift+home and shift+end change the window of the immediate fft variables, at start the immediate fft will be about 10 frames. the higher the window, the more the fft is smoothed
page up and down switch the order of the effect and modifier, so you can add noise to the whole bank, or only the previous frame's visuals
alt and the first key of each line of the keyboard are panic inputs, and will put all of the variables for the layer to the initial settings
/ will turn on and off the debug information
