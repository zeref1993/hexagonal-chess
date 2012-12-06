% The Main Game -- Top Level
% This File just maintains the state of the board and acts as the co-ordinator between the other components.

rem(X,[X|T],T).
rem(X,[Y|T],[Y|L]):- rem(X,T,L).

move([Piece,NewPos],Player,[W,B],[WNew,BNew]):-
	(Player is 1 -> Attacker = W,Z = WNew,AttackedNew = BNew,Attacked = B;
					Attacker = B,Z = BNew,AttackedNew = WNew,Attacked = W),
					
	findPosGivenPiece(Attacker,Piece,PosOfPiece),	
	rem([Piece,PosOfPiece],Attacker,Attacker_),
	
	userToThreeForm(NewPos,NewPosThree),
	Z = [[Piece,NewPosThree]|Attacker_],

	(canCapture([W,B],Player,NewPosThree,PieceCaptured) -> rem([PieceCaptured,NewPosThree],Attacked,AttackedNew);
															AttackedNew=Attacked).
	
	
play(_):-
	whiteStartPos(W),
	blackStartPos(B),
	convertBoardFromUserToThreeForm([W,B],Board),
	\+displayBoard(Board),
	readPlayer(Player),
	play(Board,Player).
	
play(Board,Player):-
	(Player is 1 -> User = W,Comp = B,
					
					readValidMove(UserMove,1,Board),
					move(UserMove,1,Board,NewBoard1),
					\+displayBoard(NewBoard1),
					(isKingAttacked(NewBoard1,2)-> nl,write('Check!'),nl;true),
					!,

					selectBestMove(NewBoard1,2,[CompMove,_]),
					move(CompMove,2,NewBoard1,NewBoard2),
					\+displayBoard(NewBoard2),
					(isKingAttacked(NewBoard2,1)-> nl,write('Check!'),nl;true),
					play(NewBoard2,	Player)
					
					;
					
					User = B,Comp = W,
					selectBestMove(Board,1,[CompMove,_]),
					move(CompMove,1,Board,NewBoard1),
					\+displayBoard(NewBoard1),
					(isKingAttacked(NewBoard1,2)-> nl,write('Check!'),nl;true),
					!,
					
					readValidMove(UserMove,2,Board),
					move(UserMove,2,NewBoard1,NewBoard2),
					\+displayBoard(NewBoard2),
					(isKingAttacked(Board,1)-> nl,write('Check!'),nl;true),
					play(NewBoard2,	Player)
	).
	

readValidMove(UserMove,Player,Board):-
		readMove(UserMove1),
		(isValid(Board,Player,UserMove1)->
			move(UserMove1,Player,Board,BoardNew),
			(isKingAttacked(BoardNew,Player)->
							nl,write('Invalid move -- King under attack'),nl,readValidMove(UserMove,Player,Board)
							;write('Valid Move '),write(UserMove1),nl,UserMove = UserMove1
			)
			;
			nl,write('Invalid Move'),nl,readValidMove(UserMove,Player,Board)).
	
				
readPlayer(X) :-
	nl,nl,write('To Play White Enter 1,To Play Black Enter 2'),nl,
  read(X).


%Format [b2,[i,5]]  
readMove(Move):-
	nl,write('Enter Move'),nl,
	read(Move).



