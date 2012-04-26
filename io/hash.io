OperatorTable addAssignOperator("$$", "hashAssign")
OperatorTable println
curlyBrackets := method(
	rs := Map clone
	call message arguments foreach(arg,
		rs doMessage(arg)
	)
	rs
)
Map hashAssign := method(
	writeln("Putting ", call evalArgAt(1), " at ", call evalArgAt(0))
)
"Hello" println
Map println
a := Map clone
a doString("\"test\" $$ \"test\"")
