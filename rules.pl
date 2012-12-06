% All checks are done assuming Three Distance Form
% This file contains the rules of pieces and checks performed
% In Three Dist Form, all square inherently have sum of distances = 18.

% A state is represented as a list of two lists -- [[W][B]]
% W and B are lists of positions.
% Each position is of form [Piece,[D1,D2,D3]].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Start Positions
whiteStartPos([[k,[g,1]],[q,[e,1]],[r1,[c,1]],[r2,[i,1]],[b1,[f,1]],[b2,[f,2]],[b3,[f,3]],[n1,[d,1]],[n2,[h,1]],[p1,[b,1]],[p2,[c,2]],[p3,[d,3]],[p4,[e,4]],[p5,[f,5]],[p6,[g,4]],[p7,[h,3]],[p8,[i,2]],[p9,[k,1]]]).

blackStartPos([[k,[g,10]],[q,[e,10]],[r1,[c,8]],[r2,[i,8]],[b1,[f,11]],[b2,[f,10]],[b3,[f,9]],[n1,[d,9]],[n2,[h,9]],[p1,[b,7]],[p2,[c,7]],[p3,[d,7]],[p4,[e,7]],[p5,[f,7]],[p6,[g,7]],[p7,[h,7]],[p8,[i,7]],[p9,[k,7]]]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boardValidCoordinate([1,2,3,4,5,6,7,8,9,10,11]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
piece(k).
piece(q).

piece(n1).
piece(n2).
piece(b3).
piece(b2).
piece(b1).
piece(r1).
piece(r2).


piece(p1).
piece(p2).
piece(p3).
piece(p4).
piece(p5).
piece(p6).
piece(p7).
piece(p8).
piece(p9).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pawns(p1).
pawns(p2).
pawns(p3).
pawns(p4).
pawns(p5).
pawns(p6).
pawns(p7).
pawns(p8).
pawns(p9).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

checkBounds([D1,D2,D3]):-

	threeFormToStandard([D1,D2,D3],[X,Y]),
	%write('In Bounds: '),write([X,Y]),nl,

	X >= 1,X =< 11,
	Y >= 1,Y =< 11,
	D1 >= 1,D1 =< 11,
	D2 >= 1,D2 =< 11,
	D3 >= 1,D3 =< 11.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Bishop

%Towards S1
unitStep(_,b,[-2,1,1]).	

%Towards S2
unitStep(_,b,[1,-2,1]).	

%Towards S3
unitStep(_,b,[1,1,-2]).	

%Away From S1
unitStep(_,b,[2,-1,-1]).	

%Away From S1
unitStep(_,b,[-1,2,-1]).	

%Away From S2
unitStep(_,b,[-1,-1,2]).	

unitStep(_,b1,X):- unitStep(_,b,X).
unitStep(_,b2,X):- unitStep(_,b,X).
unitStep(_,b3,X):- unitStep(_,b,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Rook

%Away From S1 and Towards S2
unitStep(_,r,[1,-1,0]).

%Away From S2 and Towards S3
unitStep(_,r,[0,1,-1]).

%Away From S3 and Towards S1
unitStep(_,r,[-1,0,1]).

%Towards S1 and Away From S2
unitStep(_,r,[-1,1,0]).

%Towards S2 and Away From S3
unitStep(_,r,[0,-1,1]).

%Towards S3 and Away From S1
unitStep(_,r,[1,0,-1]).

unitStep(_,r1,X):- unitStep(_,r,X).
unitStep(_,r2,X):- unitStep(_,r,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Queen


unitStep(_,q,X):-
	unitStep(_,b,X).
unitStep(_,q,X):-
	unitStep(_,r,X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%King

unitStep(_,k,X):-
	unitStep(_,q,X).

	%However, We can only move 1 unit step

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Knight

unitStep(_,n,[-3,2,1]).
unitStep(_,n,[-3,1,2]).
unitStep(_,n,[2,-3,1]).
unitStep(_,n,[1,-3,2]).
unitStep(_,n,[1,2,-3]).
unitStep(_,n,[2,1,-3]).
unitStep(_,n,[3,-2,-1]).
unitStep(_,n,[3,-1,-2]).
unitStep(_,n,[-2,-1,3]).
unitStep(_,n,[-1,-2,3]).
unitStep(_,n,[-2,3,-1]).
unitStep(_,n,[-1,3,-2]).

unitStep(_,n1,X):- unitStep(_,n,X).
unitStep(_,n2,X):- unitStep(_,n,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pawn

unitStep(1,p,[1,-1,0]).
unitStep(2,p,[-1,1,0]).
unitStep(Player,p1,X):- unitStep(Player,p,X).
unitStep(Player,p2,X):- unitStep(Player,p,X).
unitStep(Player,p3,X):- unitStep(Player,p,X).
unitStep(Player,p4,X):- unitStep(Player,p,X).
unitStep(Player,p5,X):- unitStep(Player,p,X).
unitStep(Player,p6,X):- unitStep(Player,p,X).
unitStep(Player,p7,X):- unitStep(Player,p,X).
unitStep(Player,p8,X):- unitStep(Player,p,X).
unitStep(Player,p9,X):- unitStep(Player,p,X).
%Left Hand Capture
specialStep(1,p,[0,-1,1]).
specialStep(2,p,[0,1,-1]).
%Right Hand Capture
specialStep(1,p,[1,0,-1]).
specialStep(2,p,[-1,0,1]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Helper Functions
gcd(A,B,X):-
	(0 is A-> X is B;
	(0 is B -> X is A;
		(A<0-> Y is -A; Y is A),
		(B<0-> Z is -B; Z is B),
		gcd_(Y,Z,X)
	)
	).

%a,b>0 
gcd_(A,B,X):-
	(A >= B -> gcdHelper(A,B,X) ; gcdHelper(B,A,X)).

%a>=b
gcdHelper(A,B,X):-
	(0 is mod(A,B) -> X is B ;
		Y is mod(A,B),
		gcdHelper(B,Y,X)).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
isStartingPosition([Piece,Pos],Player):-
	(Player is 1-> whiteStartPos(Board);blackStartPos(Board)),
	threeFormToUser(Pos,UserPos),
	member([Piece,UserPos],Board).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% State is the current state of the board 
% Note all three elements in query must be a constant

isValid([W,B],Player,[Piece,UserInput]):-
	userToThreeForm(UserInput,[D1,D2,D3]),
	piece(Piece),
	checkBounds([D1,D2,D3]),
	(Player is 1 -> Y = W;Y = B),
	findPosGivenPiece(Y,Piece,PosOfPiece),
	[O1,O2,O3] = PosOfPiece,
	Del1 is (D1-O1),
	Del2 is (D2-O2),
	Del3 is (D3-O3),
	gcd(Del1,Del2,Temp),
	gcd(Del3,Temp,Steps),
	(pawns(Piece)->(canCapture([W,B],Player,[D1,D2,D3],PieceAttacked)->Steps is 1;
																		(isStartingPosition([Piece,PosOfPiece],Player)->Steps>0,Steps=<2;Steps is 1));
				isStepsValid(Piece,Steps)),
	write(Steps),nl,
	U1 is (Del1//Steps),
	U2 is (Del2//Steps),
	U3 is (Del3//Steps),

	(canCapture([W,B],Player,[D1,D2,D3],PieceAttacked)-> StepsN is Steps-1;StepsN is Steps),
	(pawns(Piece)->(canCapture([W,B],Player,[D1,D2,D3],PieceAttacked)->specialStep(Player,p,[U1,U2,U3]);
																		unitStep(Player,Piece,[U1,U2,U3]));
				unitStep(Player,Piece,[U1,U2,U3])),
	noPieceInWay(Piece,[O1,O2,O3],[U1,U2,U3],StepsN,[W,B]).


%Doesnt Take into account Check
%Check for Check is done separately

findAllValid([W,B],Player,[Piece,Move]):-
	(Player is 1 -> Y = W;Y = B),
	%nl,nl,write('------------------New Piece---------------'),nl,
	piece(Piece),
	findPosGivenPiece(Y,Piece,PosOfPiece),
	[O1,O2,O3] = PosOfPiece,
	boardValidCoordinate(ValList),
	member(UserInputCol,ValList),
	numToAlpha(UserInputCol,UserInput1),
	member(UserInput2,ValList),
	userToThreeForm([UserInput1,UserInput2],[D1,D2,D3]),
	checkBounds([D1,D2,D3]),
	Del1 is (D1-O1),
	Del2 is (D2-O2),
	Del3 is (D3-O3),
	gcd(Del1,Del2,Temp),
	gcd(Del3,Temp,Steps),
	(pawns(Piece)->(canCapture([W,B],Player,[D1,D2,D3],PieceAttacked)->Steps is 1;
																		(isStartingPosition([Piece,PosOfPiece],Player)->Steps>0,Steps=<2;Steps is 1));
				isStepsValid(Piece,Steps)),
	(0 is Steps -> fail ;
	U1 is (Del1//Steps),
	U2 is (Del2//Steps),
	U3 is (Del3//Steps)),	

	%write('We have a match'),nl,
	%write(Move),nl,
	%write('Steps :'),write(Steps),nl,
	%write('Unit Move: '),write([U1,U2,U3]),nl,
	
	(canCapture([W,B],Player,[D1,D2,D3],PieceAttacked)-> StepsN is Steps-1;StepsN is Steps),
	(pawns(Piece)->(canCapture([W,B],Player,[D1,D2,D3],PieceAttacked)->specialStep(Player,p,[U1,U2,U3]);
																		unitStep(Player,Piece,[U1,U2,U3]));
				unitStep(Player,Piece,[U1,U2,U3])),
	noPieceInWay(Piece,[O1,O2,O3],[U1,U2,U3],StepsN,[W,B]),

	threeFormToUser([D1,D2,D3],Move),
	%write(Piece),write(Move),nl.
	true.
	
canCapture([W,B],Player,Move,PieceUnderAttack):-
	%(Player is 1 -> 
	%	(findPosGivenPiece(B,PieceUnderAttack,Move)->
	%		%nl,write('Black\'s '),write(PieceUnderAttack),write(' can be captured.'),nl,nl)
	%	;
	%	(findPosGivenPiece(W,PieceUnderAttack,Move)->
	%		nl,write('White\'s '),write(PieceUnderAttack),write(' can be captured.'),nl,nl)).
	
	(Player is 1 ->
		findPosGivenPiece(B,PieceUnderAttack,Move);findPosGivenPiece(W,PieceUnderAttack,Move)). 

isStepsValid(k,1).
isStepsValid(n1,1).
isStepsValid(n2,1).
isStepsValid(p1,1).
isStepsValid(p2,1).
isStepsValid(p3,1).
isStepsValid(p4,1).
isStepsValid(p5,1).
isStepsValid(p6,1).
isStepsValid(p7,1).
isStepsValid(p8,1).
isStepsValid(p9,1).
isStepsValid(q,_).
isStepsValid(r2,_).
isStepsValid(r1,_).
isStepsValid(b3,_).
isStepsValid(b2,_).
isStepsValid(b1,_).

% Cs - Current Posn 
% Us - Unit Vector
noPieceInWay(Piece,[C1,C2,C3],[U1,U2,U3],0,Board):- !.
noPieceInWay(Piece,[C1,C2,C3],[U1,U2,U3],Steps,Board):-
	[White,Black] = Board,
	N1 is C1+U1,
	N2 is C2+U2,
	N3 is C3+U3,
	%write(Steps),nl,
	%write([N1,N2,N3]),nl,	
	\+findPieceGivenPos(White,[N1,N2,N3],_),
	\+findPieceGivenPos(Black,[N1,N2,N3],_),
	%write([N1,N2,N3]),nl,	
	StepsN is Steps-1,
	%write(StepsN),nl,
	noPieceInWay(Piece,[N1,N2,N3],[U1,U2,U3],StepsN,Board).

findPosGivenPiece([],P,Q):-!,fail.
findPosGivenPiece([[P|[Pos]]|Rest],P,Pos):- %write(P),write(' Found at '),write(Pos),nl,
											!.
findPosGivenPiece([[Q|[Pos]]|Rest],P,Res):-
	%write(Pos),write('-- ' ),write(Q),nl,	
	findPosGivenPiece(Rest,P,Res).

findPieceGivenPos([],Pos,Q):-!,fail.
findPieceGivenPos([[P|[Pos]]|Rest],Pos,P):- %write(P),write(' Found at '),write(Pos),nl,
											!.
findPieceGivenPos([[P|[Q]]|Rest],Pos,Res):-
	%write(Pos),write('-- ' ),write(Q),nl,
	findPieceGivenPos(Rest,Pos,Res).

	
%Is <Player>'s king attacked in the setting?
isKingAttacked([White,Black],Player):-
	(Player is 1 -> Attacker is 2;Attacker is 1),
	findAllValid([White,Black],Attacker,[Piece,M]),
	userToThreeForm(M,Move),
	canCapture([White,Black],Attacker,Move,k).
