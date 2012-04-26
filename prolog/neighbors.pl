/*
http://en.wikipedia.org/wiki/Zebra_Puzzle
Five houses, defined as touples of (Color, Nationality, Pet, Drink, Smoke)
*/

valid_houses(List) :-
	length(List, 5), % Exactly five houses
	member((red, englishman, _, _, _), List), % The Englishman lives in the red house
	member((_, spaniard, dog, _, _), List), % The Spaniard owns a dog
	member((green, _, _, coffee, _), List), % Coffee is drunk in the green house
	member((_, ukrainian, _, tea, _), List), % The Ukrainian drinks tea
	valid_neighbor((ivory, _, _, _, _), (green, _, _, _, _), List), % The green house is immediately to the rigith of the ivory house
	member((_, _, snails, _, oldGold), List), % The Old Gold smoker owns snails
	member((yellow, _, _, _, kools), List), % Kools are smoked in the yellow house
	nth1(3, List, (_, _, _, milk, _)), % Water is drunk in the middle house
	valid_first((_, norwegian, _, _, _), List), % The Norwegian lives in the first house.
	valid_eitherNeighbor((_, _, _, _, chesterfields), (_, _, fox, _, _), List), % The man who smokes Chesterfields lives in the house next to the man with the fox
	valid_eitherNeighbor((_, _, _, _, kools), (_, _, horse, _, _), List), % Kools are smoked in a house next to the house where the horse is kept.
	member((_, _, _, orangeJuice, luckyStrike), List), % The Lucky Strike smoker drinks orange juice
	member((_, japanese, _, _, parliments), List), % The Japanese smokes Parliments.
	valid_eitherNeighbor((_, norwegian, _, _, _), (blue, _, _, _, _), List), % The Norwegian lives next to the blue house.
	
	member((_, _, _, water, _), List), % Someone drinks water...
	member((_, _, zebra, _, _), List). % Someone owns a zebra...

/*
valid_neighbor(Left, Right, HousesList) :-
	[Left| [Right|_] ] = HousesList; % If Left is followed by Right (followed by anything else), it's valid
	HousesList = [_|Tail], valid_neighbor(Left, Right, Tail). % Or, if the rest of the list has Left followed by Right.
*/
valid_neighbor(Left, Right, HousesList) :-
	nextto(Left, Right, HousesList). % SWI-Prolog command makes this more simple
	
valid_eitherNeighbor(Left, Right, HousesList) :-
	valid_neighbor(Left, Right, HousesList);
	valid_neighbor(Right, Left, HousesList).
	
valid_first(Member, [Member|_]).

zebra_owner(HousesList, Nationality) :-
	valid_houses(HousesList), % Ensure list of houses is valid
	member((_, Nationality, zebra, _, _), HousesList). % Find the member of the list with the zebra pet.