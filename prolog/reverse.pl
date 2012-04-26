reverse([Head|Tail], [Tail|Head]).
reverse([Head1|Tail1], [Head2a, Head2b|Head1]) :-
	reverse(Tail1, [Head2b, Head2a]).