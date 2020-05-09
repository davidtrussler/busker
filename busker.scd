s.boot;

// Define sound file to be used
(
~soundPath = thisProcess.nowExecutingPath.dirname +/+ "sounds/";
~buskerSnd = Buffer.read(s, ~soundPath ++ "busker.aiff");
)

// Playback rate and pan position set as arguments -->
// Define the SynthDef to play the sound file
(
SynthDef("busker", {
	arg rate = 1, pan = 0;
	Out.ar(
		0,
		{Pan2.ar(PlayBuf.ar(1, ~buskerSnd, loop: 1, rate: rate), pan)}
	)
}).add;
)

// Set playback rate
~synth.set('rate', 2);

// Set the pan position
~synth.set('pan', -1);

// <-- Playback rate and pan position set as arguments

// Play the soundfile
~synth = Synth("busker");

// Stop playback
~synth.free;

// Free Buffer memory
~buskerSnd.free;

s.quit;
