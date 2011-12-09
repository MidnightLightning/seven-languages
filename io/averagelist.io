List myAverage := method(
	total := 0
	self foreach(v, 
		if(v type != "Number", Exception raise("List contains non-number"))
		total = total + v
	)
	writeln("Total: ", total)
	writeln("Average: ", total/size(self))
)

myList := list(1,5,3,3,3,6,9)
myList myAverage

myList = list()
myList myAverage

myList = list(1,2,"3")
myList myAverage