/*
Find a combination of events running concurrently that doesn't require students to be in more than one place at one time
*/

event_students('Boomilever', ['Tom', 'Dick', 'Bill']).
event_students('Chem Lab', ['Tom', 'Dick', 'Bill']).
event_students('Astronomy', ['Jill', 'Sue', 'Beth']).
event_students('Write It, Do It', ['Jill', 'Sue', 'Beth']).
event_students('Dynamic Planet', ['Dave']).

can_run_concurrently(Event1, Event2) :-
	event_students(Event1, Students1), % There are valid students for event 1
	event_students(Event2, Students2), % and event 2
	Event1 \= Event2, % Not the same event
	Event1 @=< Event2, % and they're in alphabetical order
	exclusive_students(Students1, Students2). % and their students don't overlap

exclusive_students([], _).
exclusive_students([Head|Tail], S2) :-
	not(member(Head, S2)),
	exclusive_students(Tail, S2).

valid_slot(Events) :-
	can_run_concurrently(Event1, Event2), % Pick a random two events that can run together
	valid_slot([Event1, Event2], Events).
	
valid_slot(Events, Events).
valid_slot([Event|Tail], Events) :-
	can_run_concurrently(NewEvent, Event),
	\+ member(NewEvent, Tail),
	forall(member(Existing, Tail), can_run_concurrently(NewEvent, Existing)),
	valid_slot([NewEvent,Event|Tail], Events).

valid_schedule([Slot]) :- % one-slot schedule is only possible if...
	valid_slot(Slot),
	findall(Name, event_students(Name, _), Events),
	subset(Events, Slot). % ...all events are present in the slot
	
valid_schedule([Slot1, Slot2]) :- % two-slot schedule is only possible if...
	fail. % TODO