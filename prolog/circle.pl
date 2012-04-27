% Four-way friend CIRCLE
link(tom, bill).
link(bill, dick).
link(dick, joe).
link(joe, tom).

% Four-way friend WEB
link(jill, sally).
link(sally, beth).
link(beth, sue).
link(sue, jill).
link(jill, beth).
link(sally, sue).

friend(Person1, Person2) :- (link(Person1, Person2); link(Person2, Person1)). % Assume if one is friends with the other, it's reflexive

% Replace a forall/2 call
friendWithList(_, []).
friendWithList(Person, [Friend|Tail]) :-
	friend(Person, Friend),
	friendWithList(Person, Tail).
	
friendCircle(Friends):-
	friend(Person1, Person2),
	Person1 @=< Person2,
	validCircle([Person1, Person2], Friends).

% Given a valid web in the first input, find a valid web and put it in the output.
validCircle(Friends, Friends). % Because the input is a valid web, the simplest output is itself
validCircle([Person|Tail], Output):- % The other option is to try and grow the web
	friend(Person, NewGuy), % Grab a friend of the first person in the list... 
	NewGuy @=< Person, % ...who alphabetically comes before that person...
	\+ member(NewGuy, Tail), % ...and we don't have in the list already.
	friendWithList(NewGuy, Tail),  % If the new guys is friends with everyone already on the list...
%	forall(member(ExistingFriend, Tail), friend(NewGuy, ExistingFriend)),
	validCircle([NewGuy,Person|Tail], Output). % ...build a valid circle with the new inputs, and put that in the output slot.

