OperatorTable addAssignOperator("$$", "myAssignment")
OperatorTable println
curlyBrackets := method(
	rs := Map clone
	writeln("MESSAGE = ", call message)
	writeln("ARGS = ", call message arguments)
	call message arguments foreach(arg,
		rs doMessage(arg)
	)
	rs
)
Sequence : := method(
	writeln("MESSAGE = ", call message)
	writeln(call message name)
	#call sender atPut(call message name, )
)
Map atPutNumber := method(
	self atPut(
		call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""),
		call evalArgAt(1)
	)
)

Builder := Object clone
Builder forward := method(
	output := "<" .. call message name
	if(evalArgAt(0) type ==  "Map", 
		evalArgAt(0) foreach(i,v,
			output := " " .. i .. "=\"" .. v .. "\""
		)
	)
	output := ">"
	call message arguments foreach(arg,
		content := self doMessage(arg)
		if (content type == "Sequence", output = output .. "\n  " .. content)
	)
	output = output .. "\n" .. "</" .. call message name .. ">\n"
	return output
)

"test" $$ "test"
#a := {"test" $$ "input"}

/*
Builder ul(
	li({"id":"primary"}, "Io"),
	li("Lua"),
	li("Javascript")
) println
*/