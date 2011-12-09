ANSI := Object clone
ANSI escChr := 27 asCharacter
ANSI attributesMap := Map clone
ANSI attributesMap atPut("none", 0)
ANSI attributesMap atPut("normal", 0)
ANSI attributesMap atPut("reset", 0)
ANSI attributesMap atPut("bright", 1)
ANSI attributesMap atPut("bold", 1)
ANSI attributesMap atPut("dim", 2)
ANSI attributesMap atPut("underscore", 4)
ANSI attributesMap atPut("blink", 5)
ANSI attributesMap atPut("reverse", 7)
ANSI attributesMap atPut("hidden", 8)

ANSI attributesMap atPut("fgBlack", 30)
ANSI attributesMap atPut("fgRed", 31)
ANSI attributesMap atPut("fgGreen", 32)
ANSI attributesMap atPut("fgYellow", 33)
ANSI attributesMap atPut("fgBlue", 34)
ANSI attributesMap atPut("fgMagenta", 35)
ANSI attributesMap atPut("fgCyan", 36)
ANSI attributesMap atPut("fgWhite", 37)

ANSI attributesMap atPut("bgBlack", 40)
ANSI attributesMap atPut("bgRed", 41)
ANSI attributesMap atPut("bgGreen", 42)
ANSI attributesMap atPut("bgYellow", 43)
ANSI attributesMap atPut("bgBlue", 44)
ANSI attributesMap atPut("bgMagenta", 45)
ANSI attributesMap atPut("bgCyan", 46)
ANSI attributesMap atPut("bgWhite", 47)

ANSI mode := method(
	settings := call evalArgs
	finalSettings := list()
	settings foreach(setting,
		if(setting type == "Sequence") then(
			if(self attributesMap hasKey(setting), finalSettings append(self attributesMap at(setting))) # Look up string in Map, translating to number if possible
		) else (
			finalSettings append(setting) # Assume this is a literal number to be treated as a mode
		)
	)
	return self escChr .. "[" .. finalSettings join(";") .. "m"
)

/*
writeln(ANSI mode("bright"), "This text is bright!", ANSI mode("none"))
writeln(ANSI mode("bright","underscore","blink","reverse"), "This text is crazy!", ANSI mode("none"))
writeln(ANSI mode("fgBlack","bgRed"), "  WARNING!!  ", ANSI mode("none"))
writeln(ANSI mode(36,40), "I'm 1337 and know the ANSI codes myself!", ANSI mode(0))
*/