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

!JuegoTest methodsFor: 'as yet unclassified' stamp: 's 10/10/2019 19:12:06'!
test05YouCantPlaceXOrOInAnOccupiedSpot

	| game |
	
	game _ TerniLapilli new.
	
	self
		should: [ game putXAt: 1@1. game putOAt: 1@1.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli cantPlaceXOrOInAnOccupiedSpot ]! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 16:30:25'!
test06YouCantPlaceXOrOOutOfBounds

	| game |
	
	game _ TerniLapilli new.
	
	self
		should: [ game putXAt: 0@0.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli cantPlaceXOrOOutOfBoundsError ]! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 16:39:17'!
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
			self assert: anError messageText = TerniLapilli cantPlaceMoreThan3XOrOError. ]! !

!JuegoTest methodsFor: 'as yet unclassified' stamp: 'PB 10/13/2019 16:55:50'!
test08MoveXFromOnePositionToAnother

	| game |
	
	game _ TerniLapilli new.
	game putXAt: 1@1.
	game putOAt: 1@2.
	game putXAt: 1@3.
	game putOAt: 2@1.
	game putXAt: 2@2.
	game putOAt: 2@3.
	
	! !
