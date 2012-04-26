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
	sort([Event1, Event2], [Event1, Event2]), % and they're in alphabetical order
	exclusive_students(Students1, Students2). % and their students don't overlap

triple(A,B,C) :-
	

exclusive_students([], _).
exclusive_students([Head|Tail], S2) :-
	not(member(Head, S2)),
	exclusive_students(Tail, S2).

valid_slot([Event]) :- event_students(Event, _). % Single-element slot is valid if it's an event
valid_slot([Event1, Event2]) :-	can_run_concurrently(Event1, Event2). % Two-element slot is valid if they can be concurrent
valid_slot([Event1, Event2|Tail]) :- % three-or-more element slot is valid if...
	can_run_concurrently(Event1, Event2),
	valid_slot(Tail).

valid_schedule([Slot]) :- % one-slot schedule is only possible if...
	valid_slot(Slot),
	findall(Name, event_students(Name, _), Events),
	subset(Events, Slot). % ...all events are present in the slot
valid_schedule([Slot1, Slot2]) :- % two-slot schedule is only possible if...
	valid_slot(Slot1),
	valid_slot(Slot2),
	findall(Name, event_students(Name, _), Events),
	union(Slot1, Slot2, Events). % ...all events are present in the two slots combined
	