!classDefinition: #TerniLapilli category: #Juego!
Object subclass: #TerniLapilli
	instanceVariableNames: 'currentPlayer board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 16:12:46'!
boardAt: aPosition put: anElement

	(board at: aPosition x) at: aPosition y put: anElement. ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 16:13:11'!
initialize

	currentPlayer _ #X.
	board := Array new: 3.
	board at: 1 put: (Array new: 3).
	board at: 2 put: (Array new: 3).
	board at: 3 put: (Array new: 3).
	
	(board at: 1) at: 1 put: #E.
	(board at: 1) at: 2 put: #E.
	(board at: 1) at: 3 put: #E.
	(board at: 2) at: 1 put: #E.
	(board at: 2) at: 2 put: #E.
	(board at: 2) at: 3 put: #E.
	(board at: 3) at: 1 put: #E.
	(board at: 3) at: 2 put: #E.
	(board at: 3) at: 3 put: #E.
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 's 10/10/2019 18:44:46'!
isPlayingO

	^ currentPlayer = #O.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 's 10/10/2019 18:44:57'!
isPlayingX

	^ currentPlayer = #X.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 15:29:49'!
isXInPosition: aPosition

	^((board at: aPosition x) at: aPosition y) = #X.

	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 16:02:50'!
numberOfXAndOPlayed
	
	|number|
	
	number := 0.
	board do: [:row |
		number := number + (row occurrencesOf: #X).
		number := number + (row occurrencesOf: #O).	
	].
	^number.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 16:11:59'!
putOAt: aPosition

	self validatePlay: #O at: aPosition.
	currentPlayer _ #X.
	self boardAt: aPosition put: #O. ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 16:11:55'!
putXAt: aPosition

	self validatePlay: #X at: aPosition.
	currentPlayer _ #O.
	self boardAt: aPosition put: #X. ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 16:07:00'!
validatePlay: aPlayer at: aPosition
	
	(currentPlayer = aPlayer) ifFalse: [^Error signal: self class onePlayerCannotPlayTwiceInARowError ].
	(((board at: aPosition x) at: aPosition y) ~= #E) ifTrue:  [^Error signal: self class cantPlaceXOrOInAnOccupiedSpot ].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #Juego!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 's 10/10/2019 19:12:33'!
cantPlaceXOrOInAnOccupiedSpot

	^ 'You cannot place an X or an O in an occupied spot'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 's 10/10/2019 19:03:47'!
onePlayerCannotPlayTwiceInARowError

	^ 'One player cannot play twice in a row'.! !
