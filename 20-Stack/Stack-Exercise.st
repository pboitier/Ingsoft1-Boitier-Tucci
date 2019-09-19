!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
!OOStackTest commentStamp: '<historical>' prior: 0!
|stack|
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	stack elements!


!OOStackTest methodsFor: 'test' stamp: 'st 9/19/2019 11:45:53'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'st 9/19/2019 11:46:04'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.

	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'st 9/19/2019 11:46:15'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'st 9/19/2019 11:46:25'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'st 9/19/2019 11:46:45'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'st 9/19/2019 12:11:30'!
test06TopReturnsLastPushedObject
	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'st 9/19/2019 11:47:02'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'st 9/19/2019 11:47:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'st 9/19/2019 11:47:42'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.

	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'st 9/19/2019 11:47:53'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'st 9/19/2019 11:50:21'!
test01ShouldOnlyConsiderPrefixes

	| stack sentenceFinder expectedTestResult |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	expectedTestResult := OrderedCollection new.
	expectedTestResult add: 'testing'.
	
	stack push: 'testing'.
	stack push: 'this is a test'.
	stack push: 'itsAtest'.
	stack push: '   test'.
	
	self assert: (sentenceFinder find: 'test' in: stack) = expectedTestResult.
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'st 9/19/2019 11:50:53'!
test02ShouldNotFindSentencesIfNoneMatchesPrefix

	| stack sentenceFinder expectedTestResult |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	expectedTestResult := OrderedCollection new.
	
	stack push: 'TESTING'.
	stack push: 'this is a test'.
	stack push: 'itsAtest'.
	stack push: '   test'.
	
	self assert: (sentenceFinder find: 'test' in: stack) = expectedTestResult.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'st 9/19/2019 11:51:12'!
test03ShouldReturnAllMatchesInOrder

	| stack sentenceFinder expectedTestResult|
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	expectedTestResult := OrderedCollection new.
	expectedTestResult add: 'testing x2 this thing'.
	expectedTestResult add: 'testing this thing'.
	expectedTestResult add: 'testing'.
	
	stack push: 'testing'.
	stack push: 'testing this thing'.
	stack push: 'testing x2 this thing'.
	stack push: 'really testing this thing'.

	self assert: (sentenceFinder find: 'test' in: stack)  = expectedTestResult.
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'st 9/19/2019 12:55:19'!
test04ShouldReturnAllSentencesAppearancesEvenDuplicates

	| stack sentenceFinder expectedTestResult|
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	expectedTestResult := OrderedCollection new.
	expectedTestResult add: 'testing x2 this thing'.
	expectedTestResult add: 'testing this thing'.
	expectedTestResult add: 'testing'.
	expectedTestResult add: 'testing'.
	
	stack push: 'testing'.
	stack push: 'testing'.
	stack push: 'testing this thing'.
	stack push: 'testing x2 this thing'.
	stack push: 'really testing this thing'.

	self assert: (sentenceFinder find: 'test' in: stack)  = expectedTestResult.
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'st 9/19/2019 11:52:17'!
test05MatchingShouldBeCaseSensitive

	| stack sentenceFinder expectedTestResult |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	expectedTestResult := OrderedCollection new.
	expectedTestResult add: 'testing'.
	
	stack push: 'testing'.
	stack push: 'Testing'.
	stack push: 'teStiNg'.
	stack push: 'TESTING'.
	
	self assert: (sentenceFinder find: 'test' in: stack) = expectedTestResult.
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'st 9/19/2019 13:00:34'!
test06SearchingShouldNotAlterStackWithSentences

	| stack sentenceFinder anotherStack |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	anotherStack := OOStack new.
	anotherStack push: 'testing'.
	anotherStack push: 'testing'.
	anotherStack push: 'testing this thing'.
	anotherStack push: 'testing x2 this thing'.
	anotherStack push: 'really testing this thing'.
	
	stack push: 'testing'.
	stack push: 'testing'.
	stack push: 'testing this thing'.
	stack push: 'testing x2 this thing'.
	stack push: 'really testing this thing'.
		
	sentenceFinder find: 'test' in: stack.
		
	self assert: (self checkEqualityBetween: stack and: anotherStack).
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'st 9/19/2019 13:09:14'!
test07CanNotLookForEmptyStringInStackWithSentences

	| stack sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	stack push: 'testing'.


	self checkThatCertainAction: [ sentenceFinder find: '' in: stack ] raisesTheFollowingErrorMessage: SentenceFinderByPrefix sentenceCanNotBeEmptyOrWhiteSpace.
		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'st 9/19/2019 13:08:49'!
test08CanNotLookForWhiteSpaceInStackWithSentences

	| stack sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	stack push: 'testing'.

	self checkThatCertainAction: [ sentenceFinder find: '       ' in: stack ] raisesTheFollowingErrorMessage: SentenceFinderByPrefix sentenceCanNotBeEmptyOrWhiteSpace.

		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'st 9/19/2019 13:08:31'!
test09CanNotLookForSomethingOtherThanAStringInStackWithSentences

	| stack sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	stack push: 'testing'.

	self checkThatCertainAction: [ sentenceFinder find: 4 in: stack ] raisesTheFollowingErrorMessage: SentenceFinderByPrefix sentenceOnlyOfTypeString.
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'st 9/19/2019 13:08:08'!
test10CanNotLookForEmptyStringInEmptyStack

	| stack sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.

	self checkThatCertainAction: [ sentenceFinder find: '' in: stack ] raisesTheFollowingErrorMessage: SentenceFinderByPrefix sentenceCanNotBeEmptyOrWhiteSpace.


		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'st 9/19/2019 13:07:50'!
test11CanNotLookForWhiteSpaceInEmptyStack

	| stack sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.

	self checkThatCertainAction: [ sentenceFinder find: '       ' in: stack ] raisesTheFollowingErrorMessage: SentenceFinderByPrefix sentenceCanNotBeEmptyOrWhiteSpace.
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'st 9/19/2019 13:07:31'!
test12CanNotLookForSomethingOtherThanAStringInEmptyStack

	| stack sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	self checkThatCertainAction: [ sentenceFinder find: 4 in: stack ] raisesTheFollowingErrorMessage: SentenceFinderByPrefix sentenceOnlyOfTypeString.

		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'st 9/19/2019 13:00:04'!
test13SearchingShouldNotAlterEmptyStack

	| stack sentenceFinder anotherStack |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	anotherStack := OOStack new.
		
	sentenceFinder find: 'test' in: stack.
		
	self assert: (self checkEqualityBetween: stack and: anotherStack).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'st 9/19/2019 13:22:20'!
test14TheGivenStackShouldOnlyContainStrings

	| stack sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	stack push: 'testing'.
	stack push: 0.
	
	self checkThatCertainAction: [ sentenceFinder find: 'testing' in: stack ] raisesTheFollowingErrorMessage: SentenceFinderByPrefix stackElementsShouldOnlyBeStrings.
! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'st 9/19/2019 13:27:32'!
checkEqualityBetween: aOOStack and: anotherOOStack

	(aOOStack size = anotherOOStack size) ifFalse: [^ false].
	
	[aOOStack isEmpty] whileFalse: 
	[
		(aOOStack pop = anotherOOStack pop) ifFalse: [^ false].		
	].

	^ true.! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'st 9/19/2019 13:07:05'!
checkThatCertainAction: aClosureToRun raisesTheFollowingErrorMessage: anErrorMessageToCheck

	self should: aClosureToRun
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = anErrorMessageToCheck ]! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topOfStack size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 11:44:18'!
initialize

	topOfStack  := StackBase new.
	size := 0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 11:44:23'!
isEmpty

	^topOfStack isBase.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:12:15'!
pop

	|poppedStackElement|
	
	self top.
	
	poppedStackElement := topOfStack.
	
	topOfStack := poppedStackElement elementBelow.
	size := size - 1.
	
	^ poppedStackElement elementValue.
	
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:13:11'!
push: anElementToPush

	|stackElementToPush|
	
	stackElementToPush := StackNonBaseElement new.
	stackElementToPush initialize: anElementToPush over: topOfStack.
	topOfStack := stackElementToPush.
	size := size + 1.
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:11:52'!
size

	^size
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 11:45:11'!
top
	
	^topOfStack elementValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'st 9/19/2019 11:45:26'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:38:20'!
executeAClosure: aClosureToRun forEverySentenceIn: aStackOfSentences andStoreEachSentenceIn: anotherStackOfSentences

	[aStackOfSentences isEmpty] whileFalse: 
	[		
		aClosureToRun value.		
		anotherStackOfSentences push: aStackOfSentences pop.		
	].! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 13:22:53'!
find: aSentencePrefix in: aStackOfSentencesToLookInto
	
	| foundSentences |
	
	self validateSentencePrefix: aSentencePrefix.
	self validateStackOfSentenceState: aStackOfSentencesToLookInto.
		
	foundSentences := OrderedCollection new.
	
	self performAnActionForEverySentence: [(aStackOfSentencesToLookInto top beginsWith: aSentencePrefix) ifTrue: [foundSentences add: aStackOfSentencesToLookInto top]]                inAStackOfSentencesWhilePreservingTheStackState: aStackOfSentencesToLookInto.
	
	^ foundSentences.

	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 13:16:53'!
performAnActionForEverySentence: aClosureToRun inAStackOfSentencesWhilePreservingTheStackState: aStackOfSentencesToLookInto

	| stackToRebuild |
	
	stackToRebuild := OOStack new.	

	self executeAClosure: aClosureToRun
	forEverySentenceIn: aStackOfSentencesToLookInto
	andStoreEachSentenceIn: stackToRebuild.
	
	self executeAClosure: [] forEverySentenceIn: stackToRebuild andStoreEachSentenceIn: aStackOfSentencesToLookInto.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:17:47'!
validateSentencePrefix: aSentencePrefixToValidate

	(aSentencePrefixToValidate isKindOf: String) ifFalse:
		[^Error signal: SentenceFinderByPrefix sentenceOnlyOfTypeString].
	
	(aSentencePrefixToValidate allSatisfy: [:a | a = $ ]) ifTrue:
		[^Error signal: SentenceFinderByPrefix sentenceCanNotBeEmptyOrWhiteSpace].		
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 13:26:30'!
validateStackOfSentenceState: aStackToValidate



	self performAnActionForEverySentence: 
	[
		(aStackToValidate top isKindOf: String) ifFalse: [^Error signal: SentenceFinderByPrefix stackElementsShouldOnlyBeStrings].
	]
	 inAStackOfSentencesWhilePreservingTheStackState: aStackToValidate.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:03:31'!
sentenceCanNotBeEmptyOrWhiteSpace
	
	^ 'SentenceFinderByPrefix does not support empty or whitespace strings'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:03:27'!
sentenceOnlyOfTypeString
	
	^ 'SentenceFinderByPrefix only supports Strings'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:58:06'!
stackElementsShouldOnlyBeStrings
	
	^ 'SentenceFinderByPrefix supports stacks that only have strings'.! !


!classDefinition: #StackElement category: #'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: 'elementValue elementBelow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:02:36'!
elementBelow
	^elementBelow! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:02:38'!
elementValue
	self subclassResponsibility! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:20:59'!
initialize: value over: element

	elementValue := value.
	
	elementBelow := element! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:02:49'!
isBase
	self subclassResponsibility! !


!classDefinition: #StackBase category: #'Stack-Exercise'!
StackElement subclass: #StackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBase methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:03:08'!
elementValue

	^Error signal: OOStack stackEmptyErrorDescription.! !

!StackBase methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:03:04'!
isBase

	^true! !


!classDefinition: #StackNonBaseElement category: #'Stack-Exercise'!
StackElement subclass: #StackNonBaseElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackNonBaseElement methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:03:15'!
elementValue

	^elementValue! !

!StackNonBaseElement methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 12:03:19'!
isBase

	^false! !
