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

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 21:08:42'!
mover: anActionSequence
	
	|actionSequence anAction|
	
	actionSequence := anActionSequence asOrderedCollection.
	
	[actionSequence isEmpty] whileFalse: 
	[
		anAction := actionSequence removeFirst.
				
		self validateAction: anAction.
						
		anAction = $f ifTrue: [self avanzarMarsRover].	
		anAction = $b ifTrue: [self retrocederMarsRover ].
		anAction = $r ifTrue: [self rotarMarsRover: anAction].	
		anAction = $i ifTrue: [self rotarMarsRover: anAction].
		
	].	
	
	
			! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 19:32:38'!
position
	
	^position! !

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
