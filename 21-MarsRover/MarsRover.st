!classDefinition: #CardinalDirection category: #MarsRover!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 22:05:08'!
backwardPositionOf: aPosition

	self subclassResponsibility! !

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:36:05'!
forwardPositionOf: aPosition

	self subclassResponsibility! !

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:06:52'!
rotarDerecha

	self subclassResponsibility.! !

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:10:59'!
rotarIzquierda

	self subclassResponsibility.! !


!classDefinition: #East category: #MarsRover!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 22:05:27'!
backwardPositionOf: aPosition

	^ aPosition - (1@0).! !

!East methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:39:32'!
forwardPositionOf: aPosition

	^ aPosition + (1@0).! !

!East methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:08:37'!
rotarDerecha

	^ South new.! !

!East methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:11:36'!
rotarIzquierda

	^ North new.! !


!classDefinition: #North category: #MarsRover!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 22:05:42'!
backwardPositionOf:  aPosition

	^aPosition - (0@1).! !

!North methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:39:37'!
forwardPositionOf: aPosition

	^aPosition + (0@1).
	
	! !

!North methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:08:53'!
rotarDerecha

	^ East new.! !

!North methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:11:54'!
rotarIzquierda

	^ West new.! !


!classDefinition: #South category: #MarsRover!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 22:06:06'!
backwardPositionOf: aPosition

	^ aPosition + (0@1).! !

!South methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:39:45'!
forwardPositionOf: aPosition

	^ aPosition + (0@-1).! !

!South methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:09:36'!
rotarDerecha

	^ West new.! !

!South methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:12:21'!
rotarIzquierda

	^ East new.! !


!classDefinition: #West category: #MarsRover!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 22:06:26'!
backwardPositionOf: aPosition

	^ aPosition + (1@0).! !

!West methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:39:52'!
forwardPositionOf: aPosition

	^ aPosition + (-1@0).! !

!West methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:09:58'!
rotarDerecha

	^ North new.! !

!West methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:12:38'!
rotarIzquierda

	^South new.! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:38:25'!
avanzar

	position := direction forwardPositionOf: position.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:34:07'!
facing
	
	^direction! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:34:07'!
initializeAt: aPosition facing: aCardinalPoint

	position := aPosition.
	direction := aCardinalPoint.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:04:33'!
mover: anActionSequence
	
	|actionSequence anAction|
	
	actionSequence := self processActionSequences: anActionSequence.
	
	
	[actionSequence isEmpty] whileFalse: 
	[
		anAction := actionSequence removeFirst.
		anAction performAction: self.			
	].	
	
	
			! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 19:32:38'!
position
	
	^position! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:08:20'!
processActionSequences: anActionSequence

	|actionSequence actionSequenceToReturn anAction |
	
	actionSequence _ anActionSequence asOrderedCollection.
	actionSequenceToReturn _ OrderedCollection new. 
	
	[actionSequence isEmpty] whileFalse: 
	[
		anAction := actionSequence removeFirst.
				
		self validateAction: anAction.						
		
		anAction = $f ifTrue: [actionSequenceToReturn addLast: (MoveForward new).].	
		anAction = $b ifTrue: [actionSequenceToReturn addLast: (MoveBackwards new).].
		anAction = $r ifTrue: [actionSequenceToReturn addLast: (RotateRight new).].	
		anAction = $i ifTrue: [actionSequenceToReturn addLast: (RotateLeft new).].
		
	].	


	^actionSequenceToReturn.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 22:04:33'!
retroceder

	position := direction backwardPositionOf: position.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:34:07'!
rotarADerecha

	direction := direction rotarDerecha.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:34:07'!
rotarAIzquierda

	direction := direction rotarIzquierda.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 21:07:05'!
validateAction: anAction

	(#($f $b $i $r $ ) includes: anAction) ifFalse: [^Error signal: MarsRover invalidActionErrorDescription.]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 21:05:28'!
invalidActionErrorDescription

	^ 'Action sequence has invalid actions'.! !


!classDefinition: #MarsRoverAction category: #MarsRover!
Object subclass: #MarsRoverAction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverAction methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 21:23:31'!
performAction: aMarsRover

	^self subclassResponsibility.! !


!classDefinition: #MoveBackwards category: #MarsRover!
MarsRoverAction subclass: #MoveBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveBackwards methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:19:54'!
performAction: aMarsRover

	^ aMarsRover retroceder.! !


!classDefinition: #MoveForward category: #MarsRover!
MarsRoverAction subclass: #MoveForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveForward methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:19:23'!
performAction: aMarsRover

	^aMarsRover avanzar.! !


!classDefinition: #RotateLeft category: #MarsRover!
MarsRoverAction subclass: #RotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeft methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:20:40'!
performAction: aMarsRover

	^aMarsRover rotarAIzquierda! !


!classDefinition: #RotateRight category: #MarsRover!
MarsRoverAction subclass: #RotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRight methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:20:27'!
performAction: aMarsRover

	^aMarsRover rotarADerecha.! !
