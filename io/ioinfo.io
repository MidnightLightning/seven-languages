// Emulate a "phpinfo()" export of core messages and objects

// Method to show the inheritence tree of the Object passed to it
// Recursively calls itself until the root "Object" Object is found
ancestry := method(obj,
	obj type print
	if(obj type != "Object",
		write(" > ")
		ancestry(obj proto)
	)
)

doRelativeFile("ansi.io") # ANSI command line colors

coreObjects := Protos Core slotNames sort
writeln(ANSI mode("fgYellow", "bold"), "Core Object Types:")
writeln("==================", ANSI mode("none"))
coreObjects join(", ") println
writeln

coreObjects foreach(v,
	curObj := Protos Core getSlot(v)
	writeln(ANSI mode("bold"), curObj type)
	for (i,1, curObj type size, "=" print) // Print a number of dashes equal to the length of the name of the object
	writeln(ANSI mode("none"))
	write(ANSI mode("fgWhite"), "Slots: ", ANSI mode("none"))
	curObj slotNames sort join(", ") println
	write(ANSI mode("fgWhite"), "Ancestry: ", ANSI mode("none"))
	ancestry(curObj)
	writeln
	writeln
)
