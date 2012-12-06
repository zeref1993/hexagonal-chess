% We take the 3 distance representation for symmetry
% userForm : the form in which user inputs.
% standardFrom: after substitution. 
% displayForm : for Printing. 
%This File takes care of the conversion from 'standard' notation to 3 dist and vice-versa

% 

% Three Dist Form : 
%	D1 = Distance from S.W (\)
%	D2 = Distance from N.W (/)
%	D3 = Distance from E (|)

numToAlpha(1,a).
numToAlpha(2,b).
numToAlpha(3,c).
numToAlpha(4,d).
numToAlpha(5,e).
numToAlpha(6,f).
numToAlpha(7,g).
numToAlpha(8,h).
numToAlpha(9,i).
numToAlpha(10,k).
numToAlpha(11,l).

alphaToNum(a,1).
alphaToNum(b,2).
alphaToNum(c,3).
alphaToNum(d,4).
alphaToNum(e,5).
alphaToNum(f,6).
alphaToNum(g,7).
alphaToNum(h,8).
alphaToNum(i,9).
alphaToNum(k,10).
alphaToNum(l,11).




userToStandard([A,B],[X,B]):-
	alphaToNum(A,X).


standardToUser([A,B],[X,B]):-
	numToAlpha(A,X).

standardToThreeForm([X,Y],[D1,D2,D3]):-
	D3 is 12-X,
	( X =< 6 -> D1 is Y; D1 is (X-6+Y)),
	D2 is 18-D1-D3.

threeFormToStandard([D1,D2,D3],[X,Y]):-
	X is 12-D3,
	(X=<6 -> Y is D1;Y is (6+D1-X)).

standardToXYForm([A,B],[Y,A]):-
	(A=<6 -> Y is (18-(2*B-A)); Y is (30-(2*B+A))).

threeFormToXYForm(X,Z):-
	threeFormToStandard(X,Y),
	standardToXYForm(Y,Z).

userToThreeForm(X,Y):-
	userToStandard(X,Z),
	standardToThreeForm(Z,Y).

threeFormToUser(X,Y):-
	threeFormToStandard(X,Z),
	standardToUser(Z,Y).

convertListFromThreeFormToXY([],[]).
convertListFromThreeFormToXY([[WP,WT]|WT1],[[WP,WXY]|W1]):-
	threeFormToXYForm(WT,WXY),
	convertListFromThreeFormToXY(WT1,W1).

convertBoardFromThreeFromToXY([W,B|_],[X,Y|_]):-
	convertListFromThreeFormToXY(W,X),
	convertListFromThreeFormToXY(B,Y).

convertListFromUserToThreeForm([],[]).
convertListFromUserToThreeForm([[WP,WT]|WT1],[[WP,WXY]|W1]):-
	userToStandard(WT,ZZ),
	standardToThreeForm(ZZ,WXY),
	convertListFromUserToThreeForm(WT1,W1).

convertBoardFromUserToThreeForm([W,B],[X,Y]):-
	convertListFromUserToThreeForm(W,X),
	convertListFromUserToThreeForm(B,Y).
