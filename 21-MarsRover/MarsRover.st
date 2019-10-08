!classDefinition: #CardinalDirection category: #MarsRover!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:27:50'!
avanzar: aMarsRover

	self subclassResponsibility! !

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:45:45'!
retroceder: aMarsRover

	self subclassResponsibility! !

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:38:04'!
rotarDerecha

	self subclassResponsibility.! !

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:38:35'!
rotarIzquierda

	self subclassResponsibility.! !


!classDefinition: #East category: #MarsRover!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:46:25'!
avanzar: aMarsRover

	^ aMarsRover avanzarEste.! !

!East methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:47:33'!
retroceder: aMarsRover

	^ aMarsRover retrocederEste.! !

!East methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:38:04'!
rotarDerecha

	^ South new.! !

!East methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:38:35'!
rotarIzquierda

	^ North new.! !


!classDefinition: #North category: #MarsRover!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:28:23'!
avanzar: aMarsRover

	^aMarsRover avanzarNorte.
	
	! !

!North methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:47:46'!
retroceder: aMarsRover

	^ aMarsRover retrocederNorte.! !

!North methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:38:04'!
rotarDerecha

	^ East new.! !

!North methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:38:35'!
rotarIzquierda

	^ West new.! !


!classDefinition: #South category: #MarsRover!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:46:46'!
avanzar: aMarsRover

	^ aMarsRover avanzarSur.! !

!South methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:47:54'!
retroceder: aMarsRover

	^ aMarsRover retrocederSur.! !

!South methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:38:04'!
rotarDerecha

	^ East new.! !

!South methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:38:35'!
rotarIzquierda

	^ West new.! !


!classDefinition: #West category: #MarsRover!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:47:08'!
avanzar: aMarsRover

	^ aMarsRover avanzarOeste.! !

!West methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:48:01'!
retroceder: aMarsRover

	^ aMarsRover retrocederOeste.! !

!West methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:38:04'!
rotarDerecha

	^ North new.! !

!West methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:38:35'!
rotarIzquierda

	^ South new.! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:30:10'!
avanzar

	direction avanzar: self.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:29:50'!
avanzarEste

	position := position + (-1@0)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:28:55'!
avanzarNorte

	position := position + (0@1)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:29:13'!
avanzarOeste

	position := position + (1@0)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:29:45'!
avanzarSur

	position := position + (0@-1)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:30:10'!
facing
	
	^direction! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:30:55'!
initializeAt: aPosition facing: aCardinalDirection

	position := aPosition.
	direction := aCardinalDirection.! !

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

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:30:10'!
retroceder

	direction retroceder: self.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:45:15'!
retrocederEste

	position := position + (1@0)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:44:35'!
retrocederNorte

	position := position + (0@-1)
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:44:18'!
retrocederOeste

	position := position + (-1@0)
! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:44:54'!
retrocederSur
.
	position := position + (0@1)
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:38:51'!
rotarADerecha

	direction := direction rotarDerecha.
! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:30:10'!
rotarADerechaEste

	^direction _ North new.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:30:10'!
rotarADerechaNorte

	^direction _ West new.
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:30:10'!
rotarADerechaOeste

	^direction _ South new.
! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:30:10'!
rotarADerechaSur

	
	^direction _ East new.
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:37:10'!
rotarAIzquierda

	direction := direction rotarIzquierda.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:30:10'!
rotarAIzquierdaEste

	^direction _ South new.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:30:10'!
rotarAIzquierdaNorte

	^direction _ East new.
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:30:10'!
rotarAIzquierdaOeste

	^direction _ North new.
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 20:30:10'!
rotarAIzquierdaSur

	^direction _ West new.
	! !

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
