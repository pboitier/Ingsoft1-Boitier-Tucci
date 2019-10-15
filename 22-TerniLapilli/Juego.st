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

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 19:22:16'!
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

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 19:25:21'!
isAColumnCompleteBy: aPlayer

	|columnComplete|

	columnComplete := false.
	1 to: 3 do:[:columnNumber|
	(self isColumn: columnNumber CompleteByPlayer: aPlayer) ifTrue: [columnComplete := true.]].

	^ columnComplete.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 19:18:42'!
isADiagonalCompleteByPlayer: aPlayer

	^(((self boardAt: 1@1) = aPlayer) and:
	((self boardAt: 2@2) = aPlayer) and:
	((self boardAt: 3@3) = aPlayer))
	or:
	(((self boardAt: 1@3) = aPlayer) and:
	((self boardAt: 2@2) = aPlayer) and:
	((self boardAt: 3@1) = aPlayer)).
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 19:11:58'!
isARowCompleteBy: aPlayer

	|rowComplete|
	rowComplete := false.

	board do: [ :row | ((row occurrencesOf: aPlayer) = 3) ifTrue:[rowComplete := true ] ].

	^rowComplete. 
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 19:20:11'!
isColumn: aColumnNumber CompleteByPlayer: aPlayer

	^((self boardAt: 1@aColumnNumber) = aPlayer) and:
	((self boardAt: 2@aColumnNumber) = aPlayer and:
	((self boardAt: 3@aColumnNumber) = aPlayer)).
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 19:25:06'!
isOInPosition: aPosition

	^(self boardAt: aPosition) = #O.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 19:22:51'!
isOver

	^ playerWhoWon isNil not.
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 's 10/10/2019 18:44:46'!
isPlayingO

	^ currentPlayer = #O.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 's 10/10/2019 18:44:57'!
isPlayingX

	^ currentPlayer = #X.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 19:24:45'!
isXInPosition: aPosition

	^ (self boardAt: aPosition) = #X.

	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 18:58:38'!
moveOFrom: originalPosition to: newPosition 
	
	self validateMove: #O from: originalPosition to: newPosition.
		
	self boardAt: originalPosition put: #E.
	self boardAt: newPosition put: #O.
	self checkIfPlayerWon: #O.
	currentPlayer _ #X.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 18:58:30'!
moveXFrom: originalPosition to: newPosition 
	
	self validateMove: #X from: originalPosition to: newPosition.
	
	self boardAt: originalPosition put: #E.
	self boardAt: newPosition put: #X.
	self checkIfPlayerWon: #X.
	currentPlayer _ #O.! !

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

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 20:27:39'!
playerOWon
	^playerWhoWon = #O.
! !

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

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 18:32:47'!
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
	
	self isOver ifTrue: [Error signal: self class cantPlayAfterEitherPlayerHasWon].
	
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 18:32:58'!
validatePut: aPlayer at: aPosition
	
	|interval|
	interval := Interval from: 1 to: 3.
	((interval includes: aPosition x) and: (interval includes: aPosition y)) ifFalse: [^Error signal: self class cantPlaceXOrOOutOfBoundsError].
	(currentPlayer = aPlayer) ifFalse: [^Error signal: self class onePlayerCannotPlayTwiceInARowError ].
	((self boardAt: aPosition) ~= #E) ifTrue:  [^Error signal: self class cantPlaceXOrOInAnOccupiedSpotError ].
	((self numberOfXorOPlayedBy: aPlayer) = 3) ifTrue: [^Error signal: self class cantPlaceMoreThan3XOrOError].
	
	self isOver ifTrue: [Error signal: self class cantPlayAfterEitherPlayerHasWon].! !

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

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 18:30:29'!
cantPlayAfterEitherPlayerHasWon

	^ 'The game has ended, you cant play anymore'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 's 10/10/2019 19:03:47'!
onePlayerCannotPlayTwiceInARowError

	^ 'One player cannot play twice in a row'.! !


!classDefinition: #TerniLapilliState category: #Juego!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilliState methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 20:46:36'!
initializeFor: aTerniLapilli

	terniLapilli _ aTerniLapilli! !

!TerniLapilliState methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 20:47:37'!
isOver

	^ self subclassResponsibility.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: #Juego!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 20:43:03'!
canHandle: aTerniLapilli

	self subclassResponsibility ! !

!TerniLapilliState class methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 20:43:52'!
for: aTerniLapilli

	^self new initializeFor: aTerniLapilli! !

!TerniLapilliState class methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 20:45:55'!
stateFor: aTerniLapilli

	^(self subclasses detect: [:aTerniLapilliStateClass | aTerniLapilliStateClass canHandle: aTerniLapilli ]) for: aTerniLapilli! !


!classDefinition: #TerniLapilliMoveOState category: #Juego!
TerniLapilliState subclass: #TerniLapilliMoveOState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilliMoveOState methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 20:47:49'!
isOver

	^ false.
! !


!classDefinition: #TerniLapilliMoveXState category: #Juego!
TerniLapilliState subclass: #TerniLapilliMoveXState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilliMoveXState methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 20:48:00'!
isOver

	^ false.
! !


!classDefinition: #TerniLapilliPutOState category: #Juego!
TerniLapilliState subclass: #TerniLapilliPutOState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilliPutOState methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 20:49:02'!
isOver

	^ false.
! !


!classDefinition: #TerniLapilliPutXState category: #Juego!
TerniLapilliState subclass: #TerniLapilliPutXState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilliPutXState methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 20:49:09'!
isOver

	^ false.
! !


!classDefinition: #TerniLapilliWonOState category: #Juego!
TerniLapilliState subclass: #TerniLapilliWonOState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilliWonOState methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 20:49:16'!
isOver

	^ true.
! !


!classDefinition: #TerniLapilliWonXState category: #Juego!
TerniLapilliState subclass: #TerniLapilliWonXState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilliWonXState methodsFor: 'as yet unclassified' stamp: 'ST 10/14/2019 20:49:23'!
isOver

	^ true.
! !
