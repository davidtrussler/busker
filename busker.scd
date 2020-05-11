s.boot;

(
~soundPath = thisProcess.nowExecutingPath.dirname +/+ "sounds/";
~buskerSnd = Buffer.read(s, ~soundPath ++ "busker.aiff");
)

(
SynthDef("busker", {
	arg maxdelaytime = 0.2, delaytime = 0.2, decaytime = 1.0;

	var in = PlayBuf.ar(1, ~buskerSnd, loop: 1, rate: 1);

	Out.ar(
		0,
		{Pan2.ar(
			CombC.ar(
				in,
				maxdelaytime,
				delaytime,
				decaytime,
			), 0
		)}
	)
}).add;
)

~synth = Synth("busker");

~synth.set('maxdelaytime', 0.25);
~synth.set('delaytime', 0.25);
~synth.set('decaytime', 8);

~synth.free;

~buskerSnd.free;

s.quit;
