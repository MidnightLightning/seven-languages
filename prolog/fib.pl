fib_td(0, 1).
fib_td(1, 1).
fib_td(Index, Value) :-
	BackOne is Index - 1,
	BackTwo is Index - 2,
	fib_td(BackOne, BackOneValue), % Two calls per execution is expoential processing time!
	fib_td(BackTwo, BackTwoValue),
	Value is BackOneValue + BackTwoValue.

% http://www.daniweb.com/software-development/legacy-languages/threads/391278/fibonacci-in-prolog#post1684750
fib(Index, Value) :- fib(Index, Value, _). % If you can find a value for Index and Value, without caring what the prior value is, this is true.
fib(1,1,0). % fib(Index, MyValue, PriorValue)
fib(Index, Value, BackOneValue) :-
	Index > 1, % Index can't be negative
	BackOne is Index - 1,
	fib(BackOne, BackOneValue, BackTwoValue), % Calculate the value for Index-2, linear processing time.
	Value is BackOneValue + BackTwoValue.

/*
Fibbonacci pattern, done Bottom-up,
such that it stores the last two values as it moves up the tree, so it doesn't recalculate the value of fib(N) twice as it passes over:
fib(N) is needed to compute fib(N+1) and fib(N+2)
*/
fib_bu(Index, Value) :- fib_bu(0, 0, 1, Index, Value). % Value is the fibbonacci value of Index if there's a path from zero to Index starting with 0 and 1

% fib_bu(StartIndex, StartValueOne, StartValueTwo, TargetIndex, TargetValue)
fib_bu(Index, _, Value, Index, Value). % If the start index and the target index are the same, the target value is the last value computed
fib_bu(PriorIndex, BackTwoValue, BackOneValue, Index, Value):-
	PriorIndex < Index,
	NextIndex is PriorIndex + 1,
	Sum is BackOneValue + BackTwoValue,
	fib_bu(NextIndex, BackOneValue, Sum, Index, Value).