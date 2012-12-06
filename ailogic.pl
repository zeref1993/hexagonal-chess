%This File is responsible for the AI Logic for the game
%Abstractly, Any algo is used is given a performance metric according to which it must optimize its search
%In our case, we have used minimax


% Evaluation for Pieces
pieceValue(k,1000).
pieceValue(q,9).

pieceValue(n1,3).
pieceValue(n2,3).
pieceValue(b3,3).
pieceValue(b2,3).
pieceValue(b1,3).
pieceValue(r1,5).
pieceValue(r2,5).


pieceValue(p1,1).
pieceValue(p2,1).
pieceValue(p3,1).
pieceValue(p4,1).
pieceValue(p5,1).
pieceValue(p6,1).
pieceValue(p7,1).
pieceValue(p8,1).
pieceValue(p9,1).



	
evaluateScore([],0) :- !.
evaluateScore([[P|_]|Rest],Score):-
	evaluateScore(Rest,S),
	pieceValue(P,Val),
	Score is S+Val.
	
max(L,[BestMove,MaxScore]):-
	max_(L,[[],-9999],[BestMove,MaxScore]).

max_([],Acc,Acc).
max_([[Move,H]|T],[CurrBestMove,CurrBestScore],Final):-
	(H>CurrBestScore -> NewCurrBestScore is H,NewCurrBestMove = Move;
						NewCurrBestScore is CurrBestScore,NewCurrBestMove = CurrBestMove),
	max_(T,[NewCurrBestMove,NewCurrBestScore],Final).
	
min(L,[BestMove,MinScore]):-
	min_(L,[[],9999],[BestMove,MinScore]).

min_([],Acc,Acc).
min_([[Move,H]|T],[CurrBestMove,CurrBestScore],Final):-
	(H<CurrBestScore -> NewCurrBestScore is H,NewCurrBestMove = Move;
						NewCurrBestScore is CurrBestScore,NewCurrBestMove = CurrBestMove),
	min_(T,[NewCurrBestMove,NewCurrBestScore],Final).

	
	
	
evaluateAllPossibleMoves(Board,Player,[Move,Gain]):-
	findAllValid(Board,Player,Move),
	move(Move,Player,Board,NewBoard),
	evaluateBoard(NewBoard,Player,PlayerScore,OpponentScore),
	%nl,write('Your Score = '),write(PlayerScore),nl,nl,write('Your Opponent\'s Score = '),write(OpponentScore),nl,nl,
	Gain is PlayerScore-OpponentScore.
	
evaluateBoard([White,Black],Player,PlayerScore,OpponentScore):-
	(Player is 1 ->
		PlayerSide = White,
		OpponentSide = Black
		;
		PlayerSide = Black,
		OpponentSide = White),
	evaluateScore(PlayerSide,PlayerScore),
	evaluateScore(OpponentSide,OpponentScore).
		
findMinMaxOfAllPossibilities(Board,Player,Max,Min):-
	findall([Move,Gain],evaluateAllPossibleMoves(Board,Player,[Move,Gain]),L),	
	max(L,Max),
	min(L,Min).
	

getBestOppMove(Board,Player,[Move,Max]):-
	findAllValid(Board,Player,Move),
	move(Move,Player,Board,NewBoard),
	(Player is 1-> Opponent is 2;Opponent is 1),
	findMinMaxOfAllPossibilities(NewBoard,Opponent,Max,Min).
	%write('For the Move : '),
	%write(Move),nl,
	%write('Best Best Opp Moves: '),write(Max).
	%min(ListOfOppMax,[FinalMove,Min]),

%	findall(Max,findMinMaxOfAllPossibilities(NewBoard,Opponent,Max,Min),[BestOppMove]),	

selectBestMove(Board,Player,BestMove):-
	findall(BestOppMove,getBestOppMove(Board,Player,BestOppMove),BestMoveList),
	calcBestMove(BestMoveList,BestMove).
	
calcBestMove(L,[BestPlayerMove,[BestOppMove,MaxScore]]):-
		calcBestMove_(L,[[],[[],9999]],[BestPlayerMove,[BestOppMove,MaxScore]]).

calcBestMove_([],Acc,Acc).
calcBestMove_([[PlayerMove,[OppMove,OppScore]]|Rest],[CurrPlayerBestMove,[CurrOppBestMove,CurrBestScore]],Final):-
	(OppScore<CurrBestScore -> NewCurrBestScore is OppScore,
								NewPlayerCurrBestMove = PlayerMove,
								NewOppCurrBestMove = OppMove;
								NewCurrBestScore is CurrBestScore,
								NewPlayerCurrBestMove = CurrPlayerBestMove,
								NewOppCurrBestMove = CurrOppBestMove),
%	write('Rest: '),nl,write(Rest),nl,									
%	write('NewCurrBestScore: '),nl,write(NewCurrBestScore),nl,	
%	write('NewPlayerCurrBestMove: '),nl,write(NewPlayerCurrBestMove),nl,						
%	write('NewOppCurrBestMove: '),nl,write(NewOppCurrBestMove),nl,											
	calcBestMove_(Rest,[NewPlayerCurrBestMove,[NewOppCurrBestMove,NewCurrBestScore]],Final).
