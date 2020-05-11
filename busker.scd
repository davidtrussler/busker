s.boot;

// Define sound file to be used
(
~soundPath = thisProcess.nowExecutingPath.dirname +/+ "sounds/";
~buskerSnd = Buffer.read(s, ~soundPath ++ "busker.aiff");
)

// Define the SynthDef to play the sound file
(
SynthDef("busker", {
	arg modFreq = 440;
	var carrier = PlayBuf.ar(1, ~buskerSnd, loop: 1, rate: 1);
	var modulator_ring = SinOsc.ar(modFreq, 0, 1, 0);
	var modulator_amplitude = SinOsc.ar(modFreq, 0, 1, 0.5);
	Out.ar(
		0,
		// {Pan2.ar(carrier * modulator_ring, 0)}
		{Pan2.ar(carrier * modulator_amplitude, 0)}
	)
}).add;
)

// Play the soundfile
~synth = Synth("busker");

// Set frequency of modulator
~synth.set('modFreq', 1760);

// Stop playback
~synth.free;

// Free Buffer memory
~buskerSnd.free;

s.quit;
