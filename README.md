# MrXmasDiskGen
MATLAB function to generate custom music box disks

![Overview image](https://github.com/thecowgoesmoo/MrXmasDiskGen/blob/main/MusicBoxDisks.jpg)

## Usage
imgOut = MrXmasSil('GinuwineMyPony.mid');
Takes a midi file less than 28 seconds and scaled to white keys in the range from C3-A5.  Produces a silhoutte images for disks that will play on a Mr Christmas Symphonium music box. Next I use Inkscape to convert the images to svg (vector graphics) files.  Then I cut the disks with my K40 laser from polypropylene or cardboard.

A demo is shown here:

https://youtu.be/7X2OVvjI9SY?si=-sPoTpXdagblVogw

Depends on the midi toolbox found here:
https://github.com/miditoolbox/1.1
