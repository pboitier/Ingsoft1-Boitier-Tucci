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

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 11:09:05'!
rotateLeft

	self subclassResponsibility.! !

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 11:08:51'!
rotateRight

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

!East methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 11:09:05'!
rotateLeft

	^ North new.! !

!East methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 11:08:51'!
rotateRight

	^ South new.! !


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

!North methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 11:09:05'!
rotateLeft

	^ West new.! !

!North methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 11:08:51'!
rotateRight

	^ East new.! !


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

!South methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 11:09:05'!
rotateLeft

	^ East new.! !

!South methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 11:08:51'!
rotateRight

	^ West new.! !


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

!West methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 11:09:05'!
rotateLeft

	^South new.! !

!West methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 11:08:51'!
rotateRight

	^ North new.! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction validActions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'PB 10/8/2019 21:34:07'!
facing
	
	^direction! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 22:08:05'!
initializeAt: aPosition facing: aCardinalPoint

	position _ aPosition.
	direction _ aCardinalPoint.
	validActions _ Dictionary new.
	validActions add: $f->[MoveForward new];
				  add: $b->[MoveBackwards new]; 
				  add: $r->[RotateRight new]; 
				  add: $i->[RotateLeft new];
				  add: $ ->[DoNothing new]; 
				  yourself.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 22:11:44'!
move: anActionSequence
	
	|actionSequence anAction|
	
	actionSequence _ self processActionSequences: anActionSequence.
	
	
	[actionSequence isEmpty] whileFalse: 
	[
		anAction _ actionSequence removeFirst.
		anAction performAction: self.			
	].	
	
	
			! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 22:11:33'!
moveBackwards

	position _ direction backwardPositionOf: position.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 22:11:30'!
moveForward

	position _ direction forwardPositionOf: position.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 22:09:34'!
position
	
	^ position! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 22:11:16'!
processActionSequences: anActionSequence

	| actionSequence actionSequenceToReturn anAction |
	
	actionSequence _ anActionSequence asOrderedCollection.
	actionSequenceToReturn _ OrderedCollection new. 
	
	
	[actionSequence isEmpty] whileFalse: 
	[
		anAction _ actionSequence removeFirst.
												
		actionSequenceToReturn addLast: (validActions at: anAction ifAbsent: [^Error signal: MarsRover invalidActionErrorDescription.]) value.
		
	].	


	^ actionSequenceToReturn.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 22:11:25'!
rotateLeft

	direction _ direction rotateLeft.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 22:11:21'!
rotateRight

	direction _ direction rotateRight.! !

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


!classDefinition: #DoNothing category: #MarsRover!
MarsRoverAction subclass: #DoNothing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!DoNothing methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 22:07:51'!
performAction: aMarsRover

	^ aMarsRover.! !


!classDefinition: #MoveBackwards category: #MarsRover!
MarsRoverAction subclass: #MoveBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveBackwards methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 11:10:06'!
performAction: aMarsRover

	^ aMarsRover moveBackwards.! !


!classDefinition: #MoveForward category: #MarsRover!
MarsRoverAction subclass: #MoveForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveForward methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 11:09:29'!
performAction: aMarsRover

	^aMarsRover moveForward.! !


!classDefinition: #RotateLeft category: #MarsRover!
MarsRoverAction subclass: #RotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeft methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 11:10:43'!
performAction: aMarsRover

	^aMarsRover rotateLeft! !


!classDefinition: #RotateRight category: #MarsRover!
MarsRoverAction subclass: #RotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRight methodsFor: 'as yet unclassified' stamp: 'ST 10/9/2019 11:10:31'!
performAction: aMarsRover

	^aMarsRover rotateRight.! !
