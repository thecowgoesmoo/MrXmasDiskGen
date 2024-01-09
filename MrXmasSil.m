function imgOut = MrXmasSil(midiFile)

%Richard Moore
%January 7, 2024
%
%Take midi file less than 28 seconds and scaled to white keys in the range 
%from C3-A5.  Produce silhoutte images for disks that will play on a Mr 
%Christmas Symphonium music box. Inkscape was then used to convert the
%images to svg (vector graphics) files.  A K40 laser was then used to cut
%new disks from polypropylene sheets.  A demo is shown here:
%https://youtu.be/7X2OVvjI9SY?si=-sPoTpXdagblVogw
%
%Depends on the midi toolbox found here:
%https://github.com/miditoolbox/1.1

pixPerMm = 20;
diskRad = (895/5)*pixPerMm;
[X,Y] = meshgrid([-diskRad:1:diskRad],[-diskRad:1:diskRad]);
R = (X.^2+Y.^2).^0.5;
theta = atan2(Y,X);

%Make disk:
map = zeros(size(R));
map(find(R<diskRad)) = 1;

%Add center hole:
map(find(R<pixPerMm*26/5)) = 0;

%Add outer track:
theta2 = sin(143.*theta);
outerTrackRad = diskRad - (20/5)*pixPerMm;
innerTrackRad = outerTrackRad - (25/5)*pixPerMm;
map(find((R<=outerTrackRad)&(R>innerTrackRad)&(theta2>-0.4))) = 0;

%Read midi file:
jump=readmidi(midiFile);

%Convert the MIDI note numbers to the tine radii for the diatonic music box
%comb:
intervals = [0 2 2 1 2 2 2 1 2 2 1 2 2 2 1 2 2 1 2 2 ];
availNotes = (48+cumsum(intervals));
for x = 1:size(jump,1)
    discRad(x) = find(availNotes==jump(x,4));
end

discTh = 2.*pi.*jump(:,1)./64;

%Add holes for notes:
noteStart = (240/5)*pixPerMm;
tineSpace = (30/5)*pixPerMm;
combWidth = (570/5)*pixPerMm;
notes = [noteStart:tineSpace:(noteStart+combWidth)];

centers_R = discRad;
centers_T = discTh;
nRad = (8/5)*pixPerMm;

%Loop through the notes and add holes to the silhouette.
for x = 1:numel(centers_R)
    dis_X = notes(centers_R(x)).*cos(centers_T(x));
    dis_Y = notes(centers_R(x)).*sin(centers_T(x));
    map(find(sqrt((X-dis_X).^2+(Y-dis_Y).^2)<nRad)) = 0;
end

imgOut = map;