fib := method(i, if(i == 0 or i == 1, i, fib(i-1)+fib(i-2)))
for(x,100,110,
	x print ": " print
	fib(x) println
)
