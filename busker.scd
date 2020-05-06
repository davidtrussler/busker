s.boot;

~soundPath = thisProcess.nowExecutingPath.dirname +/+ "sounds/";
~buskerSnd = Buffer.read(s, ~soundPath ++ "busker.aiff");

(
SynthDef("busker", {
	arg pan = 0, rate = 1;
	Out.ar(
		0,
		{Pan2.ar(PlayBuf.ar(1, ~buskerSnd, loop: 1, rate: rate), pan)}
	)
}).add;
)

a = Synth("busker");

a.set('rate', 1);

a.free;

s.quit;
