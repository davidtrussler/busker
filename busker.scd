s.boot;

// Define sound file to be used
(
~soundPath = thisProcess.nowExecutingPath.dirname +/+ "sounds/";
~buskerSnd = Buffer.read(s, ~soundPath ++ "busker.aiff");
)

// Define the SynthDef to play the sound file
(
SynthDef("busker", {
	Out.ar(
		0,
		{Pan2.ar(PlayBuf.ar(1, ~buskerSnd, loop: 1, rate: 1), 0)}
	)
}).add;
)

// Play the soundfile
~synth = Synth("busker");

// Stop playback
~synth.free;

// Free Buffer memory
~buskerSnd.free;

s.quit;
