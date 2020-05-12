s.boot;

(
~soundPath = thisProcess.nowExecutingPath.dirname +/+ "sounds/";
~buskerSnd = Buffer.read(s, ~soundPath ++ "busker.aiff");
)

(
SynthDef("busker", {
	arg startPos = 0, length = 10, rate = 1, pan = 0;
	var sound, env;

	sound = PlayBuf.ar(1, ~buskerSnd, rate: rate, trigger: 1, startPos: startPos, loop: 0, doneAction: 2);
	env = EnvGen.kr(Env.triangle(length, 1), doneAction: 2);

	Out.ar(
		0,
		{Pan2.ar(sound, pan, env)}
	)
}).add;
)

~synth = Synth(\busker, [\startPos, 1000000, \length, 8, \rate, 2, \pan, -1]);

~buskerSnd.free;

s.quit;
