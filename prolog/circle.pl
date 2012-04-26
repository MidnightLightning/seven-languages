friend(tom, dick). % Three way friend circle
friend(dick, tom).
friend(tom, joe).
friend(joe, tom).
friend(dick, joe).
friend(joe, dick).

friend(tom, ben). % Two-way friend circle
friend(ben, tom).

friendCircle([Person1, Person2]) :- % Mutual friends?
	friend(Person1, Person2),
	friend(Person2, Person1).
	
friendCircle([Person1, Person2|Tail]) :-
	friendCircle([Person1, Person2]), % First two are mutual friends
	append([Person1], Tail, SubList),
	friendCircle(SubList),
	append([Person2], Tail, SubList2),
	friendCircle(SubList2).