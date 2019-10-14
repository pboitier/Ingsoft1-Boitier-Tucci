!classDefinition: #JuegoTest category: #'Juego-Test'!
TestCase subclass: #JuegoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Juego-Test'!

!JuegoTest methodsFor: 'as yet unclassified' stamp: 's 10/10/2019 18:50:13'!
test01FirstPlayerIsXAndBoardIsEmpty

	| game |
	
	game _ TerniLapilli new.
	
	self assert: 0 equals: game numberOfXAndOPlayed.
	self assert: true equals: game isPlayingX.
	
	! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 's 10/10/2019 18:47:39'!
test02AtCreationBoardIsEmptyAndOCannotPlay

	| game |
	
	game _ TerniLapilli new.
	
	self assert: 0 equals: game numberOfXAndOPlayed.
	self assert: false equals: game isPlayingO.! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 15:21:34'!
test03WhenPlayerXPlaysInAnEmptyBoardItIsCorrectlyModifiedAndNextPlayerIsO

	| game |
	
	game _ TerniLapilli new.
	
	game putXAt: 1@1.
	
	self assert: true equals: (game isXInPosition: 1@1).
	self assert: 1 equals: (game numberOfXAndOPlayed).
	self assert: true equals: game isPlayingO.! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 15:32:46'!
test04APlayerCannotPlayTwiceInARow

	| game |
	
	game _ TerniLapilli new.
	
	self
		should: [ game putXAt: 1@2. game putXAt: 2@2.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli onePlayerCannotPlayTwiceInARowError ].
				
	self assert: false equals: (game isXInPosition: 2@2).! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:34:41'!
test05YouCantPlaceXOrOInAnOccupiedSpot

	| game |
	
	game _ TerniLapilli new.
	
	self
		should: [ game putXAt: 1@1. game putOAt: 1@1.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli cantPlaceXOrOInAnOccupiedSpotError ].
		
		
	self assert: true equals: (game isXInPosition: 1@1).
	! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:35:35'!
test06YouCantPlaceXOrOOutOfBounds

	| game |
	
	game _ TerniLapilli new.
	
	self
		should: [ game putXAt: 0@0.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli cantPlaceXOrOOutOfBoundsError ].
		
		
	self assert: 0 equals: game numberOfXAndOPlayed.! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:35:57'!
test07YouCantPlaceMoreThan3XOrO

	| game |
	
	game _ TerniLapilli new.
	
	self
		should: [ game putXAt: 1@1.
				  game putOAt: 1@2.
				  game putXAt: 1@3.
				  game putOAt: 2@1.
				  game putXAt: 2@2.
				  game putOAt: 2@3.
				  game putXAt: 3@1.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli cantPlaceMoreThan3XOrOError. ].
		
	self assert: false equals: (game isXInPosition: 3@1).! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:10:09'!
test08MoveXFromOnePositionToAnother

	| game |
	
	game _ TerniLapilli new.
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
	
	game moveXFrom: 2@2 to: 3@3.
	
	self assert: true equals: (game isXInPosition: 3@3).
	self assert: false equals: (game isXInPosition: 2@2).
	self assert: 6 equals: (game numberOfXAndOPlayed).
	! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:32:26'!
test09YouCantMoveAnEmptySpace

	| game |
	
	game _ TerniLapilli new.
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
		
	self
		should: [ game moveXFrom: 3@3 to: 3@2.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli cantMoveAnEmptySpaceError ].
		
	self assert: false equals: (game isXInPosition: 3@3).	! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:32:48'!
test10YouCantMoveToAnOccupiedSpace

	| game |
	
	game _ TerniLapilli new.
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
		
	self
		should: [ game moveXFrom: 2@2 to: 2@3.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli cantMoveToAnOcuppiedSpaceError].
		
	self assert: true equals: (game isXInPosition: 2@2).
	self assert: false equals: (game isXInPosition: 2@3).	! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:33:16'!
test11YouCanOnlyMoveWhenYouHavePlaced3XOrO

	| game |
	
	game _ TerniLapilli new.
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 2@2.
	game putOAt: 2@3.
		
	self
		should: [ game moveXFrom: 2@2 to: 2@3.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli cantMoveWithLessThan3XOrOOnBoardError].
		
		
	self assert: true equals: (game isXInPosition: 2@2).
	self assert: false equals: (game isXInPosition: 2@3).	
	! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:38:21'!
test12YouCanMoveOnlyOnYourTurn

	| game |
	
	game _ TerniLapilli new.
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
		
	self
		should: [ game moveOFrom: 2@3 to: 3@3.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli canOnlyMoveOnYourTurnError].
		
		
	self assert: true equals: (game isOInPosition: 2@3).
	self assert: false equals: (game isOInPosition: 3@3).	
	! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:43:22'!
test13YouCanOnlyMoveYourPieces

	| game |
	
	game _ TerniLapilli new.
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
		
	self
		should: [ game moveXFrom: 2@3 to: 3@3.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli canOnlyMoveYourPiecesError].
		
		
	self assert: true equals: (game isOInPosition: 2@3).
	self assert: false equals: (game isOInPosition: 3@3).	
	! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'ST 10/13/2019 17:45:39'!
test14YouCantMoveOutOfBounds

	| game |
	
	game _ TerniLapilli new.
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
		
	self
		should: [ game moveXFrom: 2@3 to: 2@4.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli cantMoveOutOfBoundsError].
		
		
	self assert: true equals: (game isOInPosition: 2@3).	
	! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 16:34:51'!
test15YouCantMoveToNonNeighbourSpots

	self assert: false equals: true.
	"| game |
	
	game _ TerniLapilli new.
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
		
	self
		should: [ game moveXFrom: 1@1 to: 3@3.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli cantMoveToNonNeighbourSpotsError].
		
		
	self assert: false equals: (game isXInPosition: 3@3)."	
	! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 15:21:58'!
test16YouWinIfYouHave3XOrOinARow

	| game |
	
	game _ TerniLapilli new.
	game putXAt: 1@1.
	game putOAt: 2@1.
	game putXAt: 1@2.
	game putOAt: 2@2.
	game putXAt: 1@3.
		
	self assert: true equals: (game isOver).
	self assert: true equals: (game playerXWon).	
	! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 15:46:15'!
test17YouWinIfYouHave3XOrOinAColumn

	| game |
	
	game _ TerniLapilli new.
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 2@1.
	game putOAt: 2@2.
	game putXAt: 3@1.
		
	self assert: true equals: (game isOver).
	self assert: true equals: (game playerXWon).	
	! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'PB 10/14/2019 16:16:54'!
test18YouWinIfYouHave3XOrOinADiagonal

	| game |
	
	game _ TerniLapilli new.
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 2@2.
	game putOAt: 2@3.
	game putXAt: 3@3.
		
	self assert: true equals: (game isOver).
	self assert: true equals: (game playerXWon).	
	! !