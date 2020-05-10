s.boot;

// Define sound file to be used
(
~soundPath = thisProcess.nowExecutingPath.dirname +/+ "sounds/";
~buskerSnd = Buffer.read(s, ~soundPath ++ "busker.aiff");
)

// Define the SynthDef to play the sound file
(
SynthDef("busker", {
	arg freq = 440, rq = 1, bwr = 1, attacktime = 1, decaytime = 1, coef = 0.5, length = 3, up = 1, dn = 1;
	var input = PlayBuf.ar(1, ~buskerSnd, loop: 1, rate: 1);

	Out.ar(
		0,
		{Pan2.ar(
			LPF.ar(input, freq, mul: 1, add: 0)
			// HPF.ar(input, freq, mul: 1, add: 0)
			// BPF.ar(input, freq, rq, mul: 1, add: 0)
			// BRF.ar(input, freq, rq, mul: 1, add: 0)
			// RLPF.ar(input, freq, rq, mul: 1, add: 0)
			// RHPF.ar(input, freq, rq, mul: 1, add: 0)
			// Resonz.ar(input, freq, bwr, mul: 1, add: 0)
			// Ringz.ar(input, freq, decaytime, mul: 1, add: 0)
			// OnePole.ar(input, coef, mul: 1, add: 0)
			// OneZero.ar(input, coef, mul: 1, add: 0)
			// Median.ar(length, input, mul: 1, add: 0)
			// Slew.ar(input, up, dn, mul: 1, add: 0)
			// Formlet.ar(input, freq, attacktime, decaytime, mul: 1, add: 0)
			, 0
		)}
	)
}).add;
)

// Play the soundfile
~synth = Synth("busker");

// Set the filter cutoff frequency
~synth.set('freq', 880);

// Set the filter rq (bandwidth/cutoffFreq) value
~synth.set('rq', 1);

// Set the filter bwr (bandwidth ratio) value
~synth.set('bwr', 1);

// Set the filter attack time value
~synth.set('attacktime', 1);

// Set the filter decay time value
~synth.set('decaytime', 1);

// Set the filter coef (Feed back/forward coefficient) value
~synth.set('coef', 0.5);

// Set the filter length (number of input points in which to find the median) value (must be an odd number from 1 to 31)
~synth.set('length', 3);

// Set the up (maximum upward slope in units per second) value
~synth.set('up', 1);

// Set the dn (maximum downward slope in units per second) value
~synth.set('dn', 1);

// Stop playback
~synth.free;

// Free Buffer memory
~buskerSnd.free;

s.quit;
