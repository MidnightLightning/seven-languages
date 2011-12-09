fib := method(i, if(i == 0 or i == 1, i, fib(i-1)+fib(i-2)))
for(x,1,10, fib(x) println)
