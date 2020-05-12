s.boot;

(
~soundPath = thisProcess.nowExecutingPath.dirname +/+ "sounds/";
~buskerSnd = Buffer.read(s, ~soundPath ++ "busker.aiff");
)

(
SynthDef("busker", {
	Out.ar(
		0,
		{Pan2.ar(
			PlayBuf.ar(1, ~buskerSnd, loop: 1, rate: 1),
			0
		)}
	)
}).add;
)

~synth = Synth("busker");

~synth.free;

s.quit;
