% Display Functions

helperList(1,[6]).
helperList(2,[5,7]).
helperList(3,[4,6,8]).
helperList(4,[3,5,7,9]).
helperList(5,[2,4,6,8,10]).
helperList(6,[1,3,5,7,9,11]).
helperList(7,[2,4,6,8,10]).
helperList(8,[1,3,5,7,9,11]).
helperList(9,[2,4,6,8,10]).
helperList(10,[1,3,5,7,9,11]).
helperList(11,[2,4,6,8,10]).
helperList(12,[1,3,5,7,9,11]).
helperList(13,[2,4,6,8,10]).
helperList(14,[1,3,5,7,9,11]).
helperList(15,[2,4,6,8,10]).
helperList(16,[1,3,5,7,9,11]).
helperList(17,[2,4,6,8,10]).
helperList(18,[1,3,5,7,9,11]).
helperList(19,[2,4,6,8,10]).
helperList(20,[3,5,7,9]).
helperList(21,[4,6,8]).
helperList(22,[5,7]).
helperList(23,[6]).
helperList(24,[]).

dispRows([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]).
dispCols([1,2,3,4,5,6,7,8,9,10,11]).


getCharForVertHeader([1,6],11).
getCharForVertHeader([2,5],10).
getCharForVertHeader([2,7],10).
getCharForVertHeader([3,4],9).
getCharForVertHeader([3,8],9).
getCharForVertHeader([4,3],8).
getCharForVertHeader([4,9],8).
getCharForVertHeader([5,2],7).
getCharForVertHeader([5,10],7).
getCharForVertHeader([6,1],6).
getCharForVertHeader([6,11],6).

getCharForHorHeader(10,5).
getCharForHorHeader(12,4).
getCharForHorHeader(14,3).
getCharForHorHeader(16,2).
getCharForHorHeader(18,1).

getCharForInclHeader([19,1],a).
getCharForInclHeader([19,11],l).
getCharForInclHeader([20,2],b).
getCharForInclHeader([20,10],k).
getCharForInclHeader([21,3],c).
getCharForInclHeader([21,9],i).
getCharForInclHeader([22,4],d).
getCharForInclHeader([22,8],h).
getCharForInclHeader([23,5],e).
getCharForInclHeader([23,7],g).
getCharForInclHeader([24,6],f).

getStr(k,'K ').
getStr(q,'Q ').
getStr(r1,'R1').
getStr(r2,'R2').
getStr(b1,'B1').
getStr(b2,'B2').
getStr(b3,'B3').
getStr(n1,'N1').
getStr(n2,'N2').
getStr(p1,'P1').
getStr(p2,'P2').
getStr(p3,'P3').
getStr(p4,'P4').
getStr(p5,'P5').
getStr(p6,'P6').
getStr(p7,'P7').
getStr(p8,'P8').
getStr(p9,'P9').
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Caution -- DisplayBoard returns false after prining!


displayBoard(Board_Three):-
	convertBoardFromThreeFromToXY(Board_Three,Board),
	dispRows(DRows),
	member(N,DRows),
	helperList(N,X),
	(getCharForHorHeader(N,H)->write(' '),write(H);true),
	nl,write('   '),
	%write('---------'),write(N),write('---------'),
	draw(X,N,Board),nl,
	fail. %This fail is redundant
	

draw(L,N,[W,B|_]):-
	dispCols(DCols),
	member(Counter,DCols),
	(getCharForVertHeader([N,Counter],X)->write('\\_'),write(X),write('_/');
		(member(Counter,L)->write('\\___/');
			(getCharForInclHeader([N,Counter],XX)->write('  '),write(XX),write('  ');
				(member([Piece,[N,Counter]],W)->write(' W'),getStr(Piece,Str),write(Str),write(' ');
					(member([Piece,[N,Counter]],B)->write(' B'),getStr(Piece,Str),write(Str),write(' ');write('     '))
				)
			)
		)
	)

	,fail.
