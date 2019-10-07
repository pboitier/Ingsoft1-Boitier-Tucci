!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position facingAt'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:46:40'!
avanzarMarsRover

	facingAt = $N ifTrue: [position := position + (0@1)].
	facingAt = $O ifTrue: [position := position + (1@0)].
	facingAt = $S ifTrue: [position := position + (0@-1)].
	facingAt = $E ifTrue: [position := position + (-1@0)].
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 19:32:46'!
facingAt
	
	^facingAt! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 19:26:43'!
initializeAt: aPosition facingAt: aCardinalPoint

	position := aPosition.
	facingAt := aCardinalPoint.! !

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

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:49:43'!
retrocederMarsRover

	facingAt = $O ifTrue: [position := position + (-1@0)].
	facingAt = $N ifTrue: [position := position + (0@-1)].
	facingAt = $S ifTrue: [position := position + (0@1)].
	facingAt = $E ifTrue: [position := position + (1@0)].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:53:32'!
rotarMarsRover: anActionSequence

	anActionSequence = $r ifTrue: 
	[
		facingAt = $N ifTrue: [^facingAt := $O.].
		facingAt = $O ifTrue: [^facingAt := $S].
		facingAt = $S ifTrue: [^facingAt := $E].
		facingAt = $E ifTrue: [^facingAt := $N.].
			
	] ifFalse:
	[
		facingAt = $N ifTrue: [^facingAt := $E.].
		facingAt = $O ifTrue: [^facingAt := $N].
		facingAt = $S ifTrue: [^facingAt := $O].
		facingAt = $E ifTrue: [^facingAt := $S.].		
	]
	
	
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

!MoveBackwards methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:05:14'!
performAction: aMarsRover

	^ aMarsRover retrocederMarsRover.! !


!classDefinition: #MoveForward category: #MarsRover!
MarsRoverAction subclass: #MoveForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveForward methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 21:24:33'!
performAction: aMarsRover

	^aMarsRover avanzarMarsRover.! !


!classDefinition: #RotateLeft category: #MarsRover!
MarsRoverAction subclass: #RotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeft methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:10:19'!
performAction: aMarsRover

	^aMarsRover rotarMarsRover: $i! !


!classDefinition: #RotateRight category: #MarsRover!
MarsRoverAction subclass: #RotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRight methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 22:09:48'!
performAction: aMarsRover

	^aMarsRover rotarMarsRover: $r.! !
