!classDefinition: #TerniLapilli category: #Juego!
Object subclass: #TerniLapilli
	instanceVariableNames: 'currentPlayer board'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilli methodsFor: 'stateCheck' stamp: 'PB 10/15/2019 20:20:53'!
currentPlayer

	^currentPlayer. ! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'ST 10/15/2019 20:54:30'!
isAColumnCompleteBy: aPlayer

	^ (self isColumn: 1 CompleteByPlayer: aPlayer) or: (self isColumn: 2 CompleteByPlayer: aPlayer) or: (self isColumn: 3 CompleteByPlayer: aPlayer).! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'ST 10/14/2019 19:18:42'!
isADiagonalCompleteByPlayer: aPlayer

	^(((self boardAt: 1@1) = aPlayer) and:
	((self boardAt: 2@2) = aPlayer) and:
	((self boardAt: 3@3) = aPlayer))
	or:
	(((self boardAt: 1@3) = aPlayer) and:
	((self boardAt: 2@2) = aPlayer) and:
	((self boardAt: 3@1) = aPlayer)).
! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'ST 10/15/2019 20:57:56'!
isARowCompleteBy: aPlayer

	^ (self isRow: 1 CompleteByPlayer: aPlayer) or: (self isRow: 2 CompleteByPlayer: aPlayer) or: (self isRow: 3 CompleteByPlayer: aPlayer). 
	! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'ST 10/14/2019 19:20:11'!
isColumn: aColumnNumber CompleteByPlayer: aPlayer

	^((self boardAt: 1@aColumnNumber) = aPlayer) and:
	((self boardAt: 2@aColumnNumber) = aPlayer and:
	((self boardAt: 3@aColumnNumber) = aPlayer)).
	! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'ST 10/14/2019 19:25:06'!
isOInPosition: aPosition

	^(self boardAt: aPosition) = #O.! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'ST 10/15/2019 21:33:29'!
isOver

	^  ((self isARowCompleteBy: #X) 
	    or: (self isAColumnCompleteBy: #X))
	    or: (self isADiagonalCompleteByPlayer: #X) 
	    
	    or:
	
	    ((self isARowCompleteBy: #O) 
	    or: (self isAColumnCompleteBy: #O))
	    or: (self isADiagonalCompleteByPlayer: #O).
! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'ST 10/15/2019 21:35:16'!
isPlayingO

	^ (currentPlayer = #O) and: (self isOver not).! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'ST 10/15/2019 21:36:10'!
isPlayingX

	^ (currentPlayer = #X) and: (self isOver not).! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'ST 10/15/2019 20:57:20'!
isRow: aRowNumber CompleteByPlayer: aPlayer

	^((self boardAt: aRowNumber@1) = aPlayer) and:
	((self boardAt: aRowNumber@2) = aPlayer and:
	((self boardAt: aRowNumber@3) = aPlayer)).
	! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'ST 10/14/2019 19:24:45'!
isXInPosition: aPosition

	^ (self boardAt: aPosition) = #X.

	! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'PB 10/13/2019 16:46:59'!
numberOfXAndOPlayed
	
	^(self numberOfXorOPlayedBy: #X) + (self numberOfXorOPlayedBy: #O).	
! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'PB 10/13/2019 16:45:42'!
numberOfXorOPlayedBy: aPlayer

 	|number|
	
	number := 0.
	board do: [:row |
		number := number + (row occurrencesOf: aPlayer).	
	].
	^number! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'ST 10/15/2019 21:25:10'!
playerOWon

	^ self state playerOWon.
! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'ST 10/15/2019 21:25:33'!
playerXWon

	^ self state playerXWon.
! !

!TerniLapilli methodsFor: 'stateCheck' stamp: 'ST 10/15/2019 21:30:47'!
state

	^TerniLapilliState stateFor: self.
	! !


!TerniLapilli methodsFor: 'boardAccess' stamp: 'PB 10/13/2019 16:18:47'!
boardAt: aPosition 

	^(board at: aPosition x) at: aPosition y. ! !

!TerniLapilli methodsFor: 'boardAccess' stamp: 'PB 10/14/2019 15:24:12'!
boardAt: aPosition put: anElement

	(board at: aPosition x) at: aPosition y put: anElement.
! !


!TerniLapilli methodsFor: 'validations' stamp: 'ST 10/15/2019 20:48:48'!
validateMove: aPlayer from: originalPosition to: newPosition
	
	|interval nonDiagonalMovementSpots|
	interval := Interval from: 1 to: 3.
	((interval includes: newPosition x) and: (interval includes: newPosition y)) ifFalse: [^Error signal: self class cantMoveOutOfBoundsError].	
	((self boardAt: originalPosition) = #E) ifTrue: [Error signal: self class cantMoveAnEmptySpaceError].
	((self boardAt: newPosition) ~= #E) ifTrue: [Error signal: self class cantMoveToAnOcuppiedSpaceError].
	((self boardAt: originalPosition) = aPlayer) ifFalse: [Error signal: self class canOnlyMoveYourPiecesError]. 
	(((originalPosition y) - (newPosition y)) abs) < 2 ifFalse: [Error signal: self class cantMoveToNonNeighbourSpotsError].
	(((originalPosition x) - (newPosition x)) abs) < 2 ifFalse: [Error signal: self class cantMoveToNonNeighbourSpotsError].
	
	nonDiagonalMovementSpots := {1@2. 2@1. 2@3. 3@2.}.
	((nonDiagonalMovementSpots includes: originalPosition) and: 
	(((originalPosition x) ~= (newPosition x)) and: ((originalPosition y) ~= (newPosition y))))
	ifTrue: [Error signal: self class cantMoveToNonNeighbourSpotsError].


	
	! !

!TerniLapilli methodsFor: 'validations' stamp: 'PB 10/15/2019 20:07:54'!
validatePut: aPlayer at: aPosition
	
	|interval|
	interval := Interval from: 1 to: 3.
	((interval includes: aPosition x) and: (interval includes: aPosition y)) ifFalse: [^Error signal: self class cantPlaceXOrOOutOfBoundsError].
	((self boardAt: aPosition) ~= #E) ifTrue:  [^Error signal: self class cantPlaceXOrOInAnOccupiedSpotError ].! !


!TerniLapilli methodsFor: 'actions' stamp: 'ST 10/15/2019 20:46:05'!
moveOFrom: originalPosition to: newPosition 
	
	self state moveOFrom: originalPosition to: newPosition.! !

!TerniLapilli methodsFor: 'actions' stamp: 'ST 10/15/2019 20:41:24'!
moveXFrom: originalPosition to: newPosition 
	
	self state moveXFrom: originalPosition to: newPosition.! !

!TerniLapilli methodsFor: 'actions' stamp: 'PB 10/15/2019 20:26:27'!
putOAt: aPosition

	self state putOAt: aPosition.! !

!TerniLapilli methodsFor: 'actions' stamp: 'PB 10/15/2019 20:04:12'!
putXAt: aPosition

	self state putXAt: aPosition.! !

!TerniLapilli methodsFor: 'actions' stamp: 'ST 10/15/2019 21:37:28'!
validPlayerMoveOFrom: originalPosition to: newPosition 
	
	self validateMove: #O from: originalPosition to: newPosition.
		
	self boardAt: originalPosition put: #E.
	self boardAt: newPosition put: #O.
	currentPlayer _ #X.! !

!TerniLapilli methodsFor: 'actions' stamp: 'ST 10/15/2019 21:43:27'!
validPlayerMoveXFrom: originalPosition to: newPosition 
	
	self validateMove: #X from: originalPosition to: newPosition.
	
	self boardAt: originalPosition put: #E.
	self boardAt: newPosition put: #X.
	currentPlayer _ #O.! !

!TerniLapilli methodsFor: 'actions' stamp: 'ST 10/15/2019 21:38:23'!
validPlayerPutOAt: aPosition

	self validatePut: #O at: aPosition.
	currentPlayer _ #X.
	self boardAt: aPosition put: #O.! !

!TerniLapilli methodsFor: 'actions' stamp: 'ST 10/15/2019 21:38:40'!
validPlayerPutXAt: aPosition

	self validatePut: #X at: aPosition.
	currentPlayer _ #O.
	self boardAt: aPosition put: #X. ! !


!TerniLapilli methodsFor: 'initialize' stamp: 'ST 10/15/2019 21:29:36'!
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

!TerniLapilliState methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 20:26:38'!
putOAt: aPosition

	self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 19:46:32'!
putXAt: aPosition

	self subclassResponsibility.! !

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

!TerniLapilliMoveOState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:38:56'!
moveOFrom: originalPosition to: newPosition

	^ terniLapilli validPlayerMoveOFrom: originalPosition to: newPosition.! !

!TerniLapilliMoveOState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 20:43:30'!
moveXFrom: originalPosition to: newPosition

	^ Error signal: terniLapilli class canOnlyMoveOnYourTurnError.! !

!TerniLapilliMoveOState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:26:43'!
playerOWon

	^ false.
! !

!TerniLapilliMoveOState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:26:03'!
playerXWon

	^ false.! !

!TerniLapilliMoveOState methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 20:27:39'!
putOAt: aPosition

	^Error signal: terniLapilli class cantPlaceMoreThan3XOrOError.
! !

!TerniLapilliMoveOState methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 19:53:59'!
putXAt: aPosition

	^Error signal: terniLapilli class onePlayerCannotPlayTwiceInARowError.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliMoveOState class' category: #Juego!
TerniLapilliMoveOState class
	instanceVariableNames: ''!

!TerniLapilliMoveOState class methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 20:33:12'!
canHandle: aTerniLapilli

	|numberOfXandOPlayed|
	
	numberOfXandOPlayed := aTerniLapilli numberOfXAndOPlayed.
	^( numberOfXandOPlayed = 6) and: (aTerniLapilli currentPlayer = #O)  and: (aTerniLapilli isOver not).! !


!classDefinition: #TerniLapilliMoveXState category: #Juego!
TerniLapilliState subclass: #TerniLapilliMoveXState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilliMoveXState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 20:47:22'!
moveOFrom: originalPosition to: newPosition

	^ Error signal: terniLapilli class canOnlyMoveOnYourTurnError.! !

!TerniLapilliMoveXState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:43:27'!
moveXFrom: originalPosition to: newPosition

	^ terniLapilli validPlayerMoveXFrom: originalPosition to: newPosition.! !

!TerniLapilliMoveXState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:26:40'!
playerOWon

	^ false.
! !

!TerniLapilliMoveXState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:26:00'!
playerXWon

	^ false.! !

!TerniLapilliMoveXState methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 20:28:29'!
putOAt: aPosition

	^Error signal: terniLapilli class onePlayerCannotPlayTwiceInARowError.! !

!TerniLapilliMoveXState methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 19:52:50'!
putXAt: aPosition

	^Error signal: terniLapilli class cantPlaceMoreThan3XOrOError.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliMoveXState class' category: #Juego!
TerniLapilliMoveXState class
	instanceVariableNames: ''!

!TerniLapilliMoveXState class methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 20:32:58'!
canHandle: aTerniLapilli

	|numberOfXandOPlayed|
	
	numberOfXandOPlayed := aTerniLapilli numberOfXAndOPlayed.
	^( numberOfXandOPlayed = 6) and: (aTerniLapilli currentPlayer = #X) and: aTerniLapilli isOver not.! !


!classDefinition: #TerniLapilliPutOState category: #Juego!
TerniLapilliState subclass: #TerniLapilliPutOState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilliPutOState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 20:47:42'!
moveOFrom: originalPosition to: newPosition

	^ Error signal: terniLapilli class cantMoveWithLessThan3XOrOOnBoardError.! !

!TerniLapilliPutOState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 20:44:21'!
moveXFrom: originalPosition to: newPosition

	^ Error signal: terniLapilli class cantMoveWithLessThan3XOrOOnBoardError! !

!TerniLapilliPutOState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:26:37'!
playerOWon

	^ false.
! !

!TerniLapilliPutOState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:25:57'!
playerXWon

	^ false.! !

!TerniLapilliPutOState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:38:23'!
putOAt: aPosition
	
	^terniLapilli validPlayerPutOAt: aPosition.! !

!TerniLapilliPutOState methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 19:50:57'!
putXAt: aPosition
	
	^Error signal: terniLapilli class onePlayerCannotPlayTwiceInARowError.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPutOState class' category: #Juego!
TerniLapilliPutOState class
	instanceVariableNames: ''!

!TerniLapilliPutOState class methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 20:34:54'!
canHandle: aTerniLapilli

	|numberOfXandOPlayed|
	
	numberOfXandOPlayed := aTerniLapilli numberOfXAndOPlayed.
	^( numberOfXandOPlayed < 6) and: (aTerniLapilli currentPlayer = #O) 
	and: (aTerniLapilli isOver not).! !


!classDefinition: #TerniLapilliPutXState category: #Juego!
TerniLapilliState subclass: #TerniLapilliPutXState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilliPutXState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 20:47:47'!
moveOFrom: originalPosition to: newPosition

	^ Error signal: terniLapilli class cantMoveWithLessThan3XOrOOnBoardError.! !

!TerniLapilliPutXState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 20:44:31'!
moveXFrom: originalPosition to: newPosition

	^ Error signal: terniLapilli class cantMoveWithLessThan3XOrOOnBoardError! !

!TerniLapilliPutXState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:26:33'!
playerOWon

	^ false.
! !

!TerniLapilliPutXState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:25:53'!
playerXWon

	^ false.! !

!TerniLapilliPutXState methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 20:30:35'!
putOAt: aPosition
	
	^terniLapilli class onePlayerCannotPlayTwiceInARowError.! !

!TerniLapilliPutXState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:39:25'!
putXAt: aPosition
	
	^terniLapilli validPlayerPutXAt: aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPutXState class' category: #Juego!
TerniLapilliPutXState class
	instanceVariableNames: ''!

!TerniLapilliPutXState class methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 20:35:05'!
canHandle: aTerniLapilli

	|numberOfXandOPlayed|
	
	numberOfXandOPlayed := aTerniLapilli numberOfXAndOPlayed.
	^( numberOfXandOPlayed < 6) and: (aTerniLapilli currentPlayer = #X)
	  and: (aTerniLapilli isOver not).! !


!classDefinition: #TerniLapilliWonOState category: #Juego!
TerniLapilliState subclass: #TerniLapilliWonOState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilliWonOState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 20:47:58'!
moveOFrom: originalPosition to: newPosition

	^ Error signal: terniLapilli class cantPlayAfterEitherPlayerHasWon.! !

!TerniLapilliWonOState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 20:45:04'!
moveXFrom: originalPosition to: newPosition

	^ Error signal: terniLapilli class cantPlayAfterEitherPlayerHasWon! !

!TerniLapilliWonOState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:26:54'!
playerOWon

	^ true.
! !

!TerniLapilliWonOState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:25:48'!
playerXWon

	^ false.! !

!TerniLapilliWonOState methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 20:30:46'!
putOAt: aPosition
	
	^Error signal: terniLapilli class cantPlayAfterEitherPlayerHasWon.! !

!TerniLapilliWonOState methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 19:54:59'!
putXAt: aPosition
	
	^Error signal: terniLapilli class cantPlayAfterEitherPlayerHasWon.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliWonOState class' category: #Juego!
TerniLapilliWonOState class
	instanceVariableNames: ''!

!TerniLapilliWonOState class methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:00:12'!
canHandle: aTerniLapilli

	^ ((aTerniLapilli isARowCompleteBy: #O) 
	    or: (aTerniLapilli isAColumnCompleteBy: #O))
	    or: (aTerniLapilli isADiagonalCompleteByPlayer: #O).! !


!classDefinition: #TerniLapilliWonXState category: #Juego!
TerniLapilliState subclass: #TerniLapilliWonXState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego'!

!TerniLapilliWonXState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 20:48:03'!
moveOFrom: originalPosition to: newPosition

	^ Error signal: terniLapilli class cantPlayAfterEitherPlayerHasWon.! !

!TerniLapilliWonXState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 20:45:11'!
moveXFrom: originalPosition to: newPosition

	^ Error signal: terniLapilli class cantPlayAfterEitherPlayerHasWon! !

!TerniLapilliWonXState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:26:29'!
playerOWon

	^ false.
! !

!TerniLapilliWonXState methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:26:08'!
playerXWon

	^ true.! !

!TerniLapilliWonXState methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 20:30:51'!
putOAt: aPosition
	
	^Error signal: terniLapilli class cantPlayAfterEitherPlayerHasWon.! !

!TerniLapilliWonXState methodsFor: 'as yet unclassified' stamp: 'PB 10/15/2019 19:55:08'!
putXAt: aPosition
	
	^Error signal: terniLapilli class cantPlayAfterEitherPlayerHasWon.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliWonXState class' category: #Juego!
TerniLapilliWonXState class
	instanceVariableNames: ''!

!TerniLapilliWonXState class methodsFor: 'as yet unclassified' stamp: 'ST 10/15/2019 21:00:28'!
canHandle: aTerniLapilli

	^((aTerniLapilli isARowCompleteBy: #X) 
	    or: (aTerniLapilli isAColumnCompleteBy: #X))
	    or: (aTerniLapilli isADiagonalCompleteByPlayer: #X).! !
