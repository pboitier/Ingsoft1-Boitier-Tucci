!classDefinition: #TerniLapilli category: #Juego!
Object subclass: #TerniLapilli
	instanceVariableNames: 'currentPlayer board playerWhoWon'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 16:18:47'!
boardAt: aPosition 

	^(board at: aPosition x) at: aPosition y. ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 15:24:12'!
boardAt: aPosition put: anElement

	(board at: aPosition x) at: aPosition y put: anElement.
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 16:33:32'!
checkIfPlayerWon: aPlayer

	|playerWon|
	
	playerWon := ((self isARowCompleteBy: aPlayer) 
				    or: (self isAColumnCompleteBy: aPlayer))
				    or: (self isADiagonalCompleteByPlayer: aPlayer).

	playerWon ifTrue: [playerWhoWon := aPlayer.]! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 15:11:25'!
initialize

	currentPlayer _ #X.
	playerWhoWon _ nil.
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

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 16:30:42'!
isAColumnCompleteBy: aPlayer

	|columnComplete|

	columnComplete := false.
	1 to: 3 do:[:columnNumber|
	(self isColumn: columnNumber CompleteByPlayer: aPlayer) ifTrue: [columnComplete := true.]].

	^columnComplete.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 16:32:36'!
isADiagonalCompleteByPlayer: aPlayer

	^((((board at: 1) at: 1) = aPlayer) and:
	((board at: 2) at: 2) = aPlayer and:
	(((board at: 3) at: 3) = aPlayer))
	or:
	((((board at: 1) at: 3) = aPlayer) and:
	((board at: 2) at: 2) = aPlayer and:
	(((board at: 3) at: 1) = aPlayer)).
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 16:28:39'!
isARowCompleteBy: aPlayer

	|rowComplete|
	rowComplete := false.
	board do: [:row |
		((row occurrencesOf: aPlayer) = 3) ifTrue:[rowComplete := true.]. 	
	].
	^rowComplete. 
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 16:16:03'!
isColumn: aColumnNumber CompleteByPlayer: aPlayer

	^(((board at: 1) at: aColumnNumber) = aPlayer) and:
	((board at: 2) at: aColumnNumber) = aPlayer and:
	(((board at: 3) at: aColumnNumber) = aPlayer).
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:39:46'!
isOInPosition: aPosition

	^((board at: aPosition x) at: aPosition y) = #O.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 15:22:09'!
isOver
	^playerWhoWon isNil not.
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

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:49:28'!
moveOFrom: originalPosition to: newPosition 
	
	self validateMove: #O from: originalPosition to: newPosition.
		
	self boardAt: originalPosition put: #E.
	self boardAt: newPosition put: #O.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:49:49'!
moveXFrom: originalPosition to: newPosition 
	
	self validateMove: #X from: originalPosition to: newPosition.
		
	self boardAt: originalPosition put: #E.
	self boardAt: newPosition put: #X.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 16:46:59'!
numberOfXAndOPlayed
	
	^(self numberOfXorOPlayedBy: #X) + (self numberOfXorOPlayedBy: #O).	
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 16:45:42'!
numberOfXorOPlayedBy: aPlayer

 	|number|
	
	number := 0.
	board do: [:row |
		number := number + (row occurrencesOf: aPlayer).	
	].
	^number! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 15:22:50'!
playerXWon
	^playerWhoWon = #X.
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 15:24:25'!
putOAt: aPosition

	self validatePut: #O at: aPosition.
	currentPlayer _ #X.
	self boardAt: aPosition put: #O.
	self checkIfPlayerWon: #O. ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 15:24:21'!
putXAt: aPosition

	self validatePut: #X at: aPosition.
	currentPlayer _ #O.
	self boardAt: aPosition put: #X. 
	self checkIfPlayerWon: #X.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 17:20:25'!
validateMove: aPlayer from: originalPosition to: newPosition
	
	|interval nonDiagonalMovementSpots|
	interval := Interval from: 1 to: 3.
	((interval includes: newPosition x) and: (interval includes: newPosition y)) ifFalse: [^Error signal: self class cantMoveOutOfBoundsError].	
	((self numberOfXorOPlayedBy: aPlayer) < 3) ifTrue: [Error signal: self class cantMoveWithLessThan3XOrOOnBoardError].
	((self boardAt: originalPosition) = #E) ifTrue: [Error signal: self class cantMoveAnEmptySpaceError].
	((self boardAt: newPosition) ~= #E) ifTrue: [Error signal: self class cantMoveToAnOcuppiedSpaceError].
	((self boardAt: originalPosition) = aPlayer) ifFalse: [Error signal: self class canOnlyMoveYourPiecesError]. 
	(currentPlayer = aPlayer) ifFalse: [Error signal: self class canOnlyMoveOnYourTurnError].
	(((originalPosition y) - (newPosition y)) abs) < 2 ifFalse: [Error signal: self class cantMoveToNonNeighbourSpotsError].
	(((originalPosition x) - (newPosition x)) abs) < 2 ifFalse: [Error signal: self class cantMoveToNonNeighbourSpotsError].
	
	nonDiagonalMovementSpots := {1@2. 2@1. 2@3. 3@2.}.
	((nonDiagonalMovementSpots includes: originalPosition) and: 
	(((originalPosition x) ~= (newPosition x)) and: ((originalPosition y) ~= (newPosition y))))
	ifTrue: [Error signal: self class cantMoveToNonNeighbourSpotsError].
	
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:46:17'!
validatePut: aPlayer at: aPosition
	
	|interval|
	interval := Interval from: 1 to: 3.
	((interval includes: aPosition x) and: (interval includes: aPosition y)) ifFalse: [^Error signal: self class cantPlaceXOrOOutOfBoundsError].
	(currentPlayer = aPlayer) ifFalse: [^Error signal: self class onePlayerCannotPlayTwiceInARowError ].
	((self boardAt: aPosition) ~= #E) ifTrue:  [^Error signal: self class cantPlaceXOrOInAnOccupiedSpotError ].
	((self numberOfXorOPlayedBy: aPlayer) = 3) ifTrue: [^Error signal: self class cantPlaceMoreThan3XOrOError]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #Juego!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:39:11'!
canOnlyMoveOnYourTurnError

	^ 'You can only move on your turn'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:43:37'!
canOnlyMoveYourPiecesError

	^ 'You can only move your pieces'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:14:22'!
cantMoveAnEmptySpaceError

	^ 'You cant move an empty space'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:45:57'!
cantMoveOutOfBoundsError

	^ 'You cant move a piece out of bounds'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:18:58'!
cantMoveToAnOcuppiedSpaceError

	^ 'You cant move to an occupied space'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 14:48:42'!
cantMoveToNonNeighbourSpotsError

	^ 'You can only move to neighbour spots'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:28:44'!
cantMoveWithLessThan3XOrOOnBoardError

	^ 'You cant move with less than 3 X or O place on the board'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 16:39:53'!
cantPlaceMoreThan3XOrOError

	^ 'cant place more than 3 X Or O'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:19:08'!
cantPlaceXOrOInAnOccupiedSpotError

	^ 'You cannot place an X or an O in an occupied spot'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 16:17:58'!
cantPlaceXOrOOutOfBoundsError

	^ 'cant place X Or O Out Of Bounds'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 's 10/10/2019 19:03:47'!
onePlayerCannotPlayTwiceInARowError

	^ 'One player cannot play twice in a row'.! !
