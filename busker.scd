s.boot;

(
~soundPath = thisProcess.nowExecutingPath.dirname +/+ "sounds/";
~buskerSnd = Buffer.read(s, ~soundPath ++ "busker.aiff");
)

(
SynthDef("busker", {
	arg startPos = 0, length = 4, rate = 1, pan = 0;
	var sound, env;

	sound = PlayBuf.ar(1, ~buskerSnd, rate: rate, trigger: 1, startPos: startPos, loop: 0, doneAction: 2);
	env = EnvGen.kr(Env.triangle(length, 1), doneAction: 2);

	Out.ar(
		0,
		{Pan2.ar(sound, pan, env)}
	)
}).add;
)

(
r = Routine({
    [-1, 0, 1].scramble.do {
        arg pan;

		var length = rand(6.0) + 2;
		var startPos = rand(~buskerSnd.numFrames - (~length * 44100)).floor;

		("length: "++length).postln;
		("startPos: "++startPos).postln;

        Synth(\busker, [\rate, 1, \pan, pan, \length, length, \startPos, startPos]);
        1.wait
    }
}).loop
)

r.play;
r.stop;

~buskerSnd.free;

s.quit;
