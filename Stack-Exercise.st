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


!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'PB 9/19/2019 07:41:51'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.

	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
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

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'PB 9/17/2019 17:57:10'!
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

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'PB 9/19/2019 08:42:59'!
test01ShouldFindSentenceIfThereIsAMatch

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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'PB 9/19/2019 08:42:04'!
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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'PB 9/19/2019 08:41:06'!
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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'PB 9/19/2019 08:44:23'!
test04ShouldReturnAllSentencesAppearances

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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'PB 9/19/2019 08:44:37'!
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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'PB 9/19/2019 09:00:31'!
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
		
	self assert: (SentenceFinderByPrefixTest checkEqualityBetween: stack and: anotherStack).
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'PB 9/19/2019 08:53:17'!
test07CanNotLookForEmptyStringInStackWithSentences

	| stack sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	stack push: 'testing'.

	self
		should: [ sentenceFinder find: '' in: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix sentenceCanNotBeEmptyOrWhiteSpace ]
		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'PB 9/19/2019 08:53:30'!
test08CanNotLookForWhiteSpaceInStackWithSentences

	| stack sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	stack push: 'testing'.

	self
		should: [ sentenceFinder find: '       ' in: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix sentenceCanNotBeEmptyOrWhiteSpace ]
		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'PB 9/19/2019 08:53:43'!
test09CanNotLookForSomethingOtherThanAStringInStackWithSentences

	| stack sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	stack push: 'testing'.

	self
		should: [ sentenceFinder find: 4 in: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix sentenceOnlyOfTypeString ]
		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'PB 9/19/2019 08:52:10'!
test10CanNotLookForEmptyStringInEmptyStack

	| stack sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.

	self
		should: [ sentenceFinder find: '' in: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix sentenceCanNotBeEmptyOrWhiteSpace ]
		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'PB 9/19/2019 08:52:26'!
test11CanNotLookForWhiteSpaceInEmptyStack

	| stack sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.

	self
		should: [ sentenceFinder find: '       ' in: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix sentenceCanNotBeEmptyOrWhiteSpace ]
		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'PB 9/19/2019 08:52:55'!
test12CanNotLookForSomethingOtherThanAStringInEmptyStack

	| stack sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.

	self
		should: [ sentenceFinder find: 4 in: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix sentenceOnlyOfTypeString ]
		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'PB 9/19/2019 08:59:55'!
test13SearchingShouldNotAlterEmptyStack

	| stack sentenceFinder anotherStack |
	
	sentenceFinder := SentenceFinderByPrefix new.
	stack := OOStack new.
	
	anotherStack := OOStack new.
		
	sentenceFinder find: 'test' in: stack.
		
	self assert: (SentenceFinderByPrefixTest checkEqualityBetween: stack and: anotherStack).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefixTest class' category: #'Stack-Exercise'!
SentenceFinderByPrefixTest class
	instanceVariableNames: ''!

!SentenceFinderByPrefixTest class methodsFor: 'testHelpers' stamp: 'st 9/19/2019 00:08:54'!
checkEqualityBetween: aOOStack and: anotherOOStack

	(aOOStack size = anotherOOStack size) ifFalse: [^ false].
	
	[aOOStack isEmpty] whileFalse: 
	[
		(aOOStack pop = anotherOOStack pop) ifFalse: [^ false].		
	].

	^ true.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topOfStack size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'PB 9/17/2019 20:22:08'!
initialize
	topOfStack  := StackBase new.
	size := 0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'PB 9/17/2019 19:20:09'!
isEmpty

	^topOfStack isBase.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'st 9/19/2019 00:03:20'!
pop
	|poppedStackElement|
	self top.
	poppedStackElement := topOfStack.
	topOfStack := poppedStackElement elementBelow.
	size := size - 1.
	^ poppedStackElement elementValue.
	
	
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'PB 9/17/2019 20:21:28'!
push: elementValue

	|stackElementToPush|
	
	stackElementToPush := StackNonBaseElement new.
	stackElementToPush initialize: elementValue over: topOfStack.
	topOfStack := stackElementToPush.
	size := size + 1.
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'PB 9/17/2019 20:30:40'!
size
	^size
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'PB 9/17/2019 19:22:57'!
top
	
	^topOfStack elementValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'st 9/18/2019 23:35:27'!
find: aSentence in: aStackOfSentences
	
	| stackToRebuild  foundSentences actualSentence |
	
	foundSentences := OrderedCollection new.
	stackToRebuild := OOStack new.
	
	self validateSentence: aSentence.
		
	[aStackOfSentences isEmpty] whileFalse: 
	[
		actualSentence := aStackOfSentences pop.
		stackToRebuild push: actualSentence.
		(actualSentence beginsWith: aSentence) ifTrue:
		[foundSentences add: actualSentence].
	].

	[stackToRebuild isEmpty] whileFalse:
	[
		actualSentence := stackToRebuild pop.
		aStackOfSentences push: actualSentence.
		
	].

	
	^ foundSentences.

	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'st 9/18/2019 15:56:15'!
validateSentence: aSentence

	(aSentence isKindOf: String) ifFalse:
		[^Error signal: SentenceFinderByPrefix sentenceOnlyOfTypeString].
		
	(aSentence allSatisfy: [:a | a = $ ]) ifTrue:
		[^Error signal: SentenceFinderByPrefix sentenceCanNotBeEmptyOrWhiteSpace].		
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'st 9/18/2019 15:56:02'!
sentenceCanNotBeEmptyOrWhiteSpace
	
	^ 'SentenceFinderByPrefix does not support empty or whitespace strings'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'st 9/18/2019 15:40:22'!
sentenceOnlyOfTypeString
	
	^ 'SentenceFinderByPrefix only supports Strings'.! !


!classDefinition: #StackElement category: #'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: 'elementValue elementBelow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'as yet unclassified' stamp: 'PB 9/17/2019 20:13:24'!
elementBelow
	^elementBelow! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'PB 9/17/2019 19:24:26'!
elementValue
	self subclassResponsibility! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'PB 9/17/2019 19:37:18'!
initialize: value over: element
	elementValue := value.
	elementBelow := element! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'PB 9/17/2019 19:16:39'!
isBase
	self subclassResponsibility! !


!classDefinition: #StackBase category: #'Stack-Exercise'!
StackElement subclass: #StackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBase methodsFor: 'as yet unclassified' stamp: 'PB 9/17/2019 19:31:04'!
elementValue
	^Error signal: OOStack stackEmptyErrorDescription.! !

!StackBase methodsFor: 'as yet unclassified' stamp: 'PB 9/17/2019 19:16:58'!
isBase
	^true! !


!classDefinition: #StackNonBaseElement category: #'Stack-Exercise'!
StackElement subclass: #StackNonBaseElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackNonBaseElement methodsFor: 'as yet unclassified' stamp: 'PB 9/17/2019 19:33:31'!
elementValue
	^elementValue! !

!StackNonBaseElement methodsFor: 'as yet unclassified' stamp: 'PB 9/17/2019 19:17:10'!
isBase
	^false! !
