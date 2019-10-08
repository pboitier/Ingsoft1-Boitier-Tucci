!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position facing'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/7/2019 13:42:12'!
avanzar

	facing avanzar: self.! !

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

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/7/2019 13:43:31'!
facing
	
	^facing! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/7/2019 13:43:41'!
initializeAt: aPosition facing: aCardinalPoint

	position := aPosition.
	facing := aCardinalPoint.! !

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

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/7/2019 13:42:12'!
retroceder

	facing retroceder: self.! !

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

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/7/2019 13:42:12'!
rotarADerecha

	^facing rotarDerecha: self.
! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/7/2019 13:42:12'!
rotarADerechaEste

	^facing _ FacingNorth new.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/7/2019 13:52:03'!
rotarADerechaNorte

	^facing _ FacingWest new.
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/7/2019 13:42:12'!
rotarADerechaOeste

	^facing _ FacingSouth new.
! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/7/2019 13:42:12'!
rotarADerechaSur

	
	^facing _ FacingEast new.
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/7/2019 13:42:12'!
rotarAIzquierda

	^facing rotarIzquierda: self.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/7/2019 13:42:12'!
rotarAIzquierdaEste

	^facing _ FacingSouth new.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/7/2019 13:42:12'!
rotarAIzquierdaNorte

	^facing _ FacingEast new.
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/7/2019 13:42:12'!
rotarAIzquierdaOeste

	^facing _ FacingNorth new.
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/7/2019 13:42:12'!
rotarAIzquierdaSur

	^facing _ FacingWest new.
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


!classDefinition: #MarsRoverState category: #MarsRover!
Object subclass: #MarsRoverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverState methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:27:50'!
avanzar: aMarsRover

	self subclassResponsibility! !

!MarsRoverState methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:45:45'!
retroceder: aMarsRover

	self subclassResponsibility! !

!MarsRoverState methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:53:25'!
rotarDerecha: aMarsRover

	self subclassResponsibility.! !

!MarsRoverState methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:56:06'!
rotarIzquierda: aMarsRover

	self subclassResponsibility.! !


!classDefinition: #FacingEast category: #MarsRover!
MarsRoverState subclass: #FacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingEast methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:46:25'!
avanzar: aMarsRover

	^ aMarsRover avanzarEste.! !

!FacingEast methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:47:33'!
retroceder: aMarsRover

	^ aMarsRover retrocederEste.! !

!FacingEast methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:53:30'!
rotarDerecha: aMarsRover

	^ aMarsRover rotarADerechaEste.! !

!FacingEast methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:56:31'!
rotarIzquierda: aMarsRover

	^ aMarsRover rotarAIzquierdaEste.! !


!classDefinition: #FacingNorth category: #MarsRover!
MarsRoverState subclass: #FacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingNorth methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:28:23'!
avanzar: aMarsRover

	^aMarsRover avanzarNorte.
	
	! !

!FacingNorth methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:47:46'!
retroceder: aMarsRover

	^ aMarsRover retrocederNorte.! !

!FacingNorth methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:53:40'!
rotarDerecha: aMarsRover

	^ aMarsRover rotarADerechaNorte.! !

!FacingNorth methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:56:43'!
rotarIzquierda: aMarsRover

	^ aMarsRover rotarAIzquierdaNorte.! !


!classDefinition: #FacingSouth category: #MarsRover!
MarsRoverState subclass: #FacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingSouth methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:46:46'!
avanzar: aMarsRover

	^ aMarsRover avanzarSur.! !

!FacingSouth methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:47:54'!
retroceder: aMarsRover

	^ aMarsRover retrocederSur.! !

!FacingSouth methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:53:50'!
rotarDerecha: aMarsRover

	^ aMarsRover rotarADerechaSur.! !

!FacingSouth methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:56:51'!
rotarIzquierda: aMarsRover

	^ aMarsRover rotarAIzquierdaSur.! !


!classDefinition: #FacingWest category: #MarsRover!
MarsRoverState subclass: #FacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingWest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:47:08'!
avanzar: aMarsRover

	^ aMarsRover avanzarOeste.! !

!FacingWest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:48:01'!
retroceder: aMarsRover

	^ aMarsRover retrocederOeste.! !

!FacingWest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:54:04'!
rotarDerecha: aMarsRover

	^ aMarsRover rotarADerechaOeste.! !

!FacingWest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:57:01'!
rotarIzquierda: aMarsRover

	^ aMarsRover rotarAIzquierdaOeste.! !
