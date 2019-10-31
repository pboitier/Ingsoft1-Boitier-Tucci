!classDefinition: #CartTest category: #TusLibros stamp: 'PB 10/31/2019 00:14:12'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'test' stamp: 'PB 10/30/2019 23:00:46'!
test01CanCreateCartWithValidCredentialsAndItsEmpty

	|cart|
	
	cart := Cart new.
	self assert: true equals: cart isEmpty.
	! !

!CartTest methodsFor: 'test' stamp: 'PB 10/30/2019 23:22:13'!
test02AddingBooksToEmptyCartMakesItNotEmpty

	|cart|
	
	cart := Cart new.
	cart add: 1 booksOfISBN: 123.   
	self assert: false equals: cart isEmpty.
	! !

!CartTest methodsFor: 'test' stamp: 'PB 10/30/2019 23:37:44'!
test03CannotAddNegativeBooksToCart

	|cart|
	
	cart := Cart new.
	cart add: 1 booksOfISBN: 123. 
	self should: [cart add: -1 booksOfISBN: 123.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError | self assert: (anError messageText = Cart cannotAddNegativeBooksError). ]. 
	  
	self assert: false equals: cart isEmpty.
	! !

!CartTest methodsFor: 'test' stamp: 'PB 10/30/2019 23:39:52'!
test04ListingEmptyCartReturnsEmptyList

	|cart|
	
	cart := Cart new.
	  
	self assert: cart list equals: ''.
	! !

!CartTest methodsFor: 'test' stamp: 'PB 10/31/2019 00:09:51'!
test05ListingNonEmptyCartWorksCorrectly

	|cart|
	
	cart := Cart new.
	cart add: 1 booksOfISBN: 123.
	cart add: 2 booksOfISBN: 123.
	self assert: cart list equals: '123 3'.
	! !


!classDefinition: #Cart category: #TusLibros stamp: 'PB 10/31/2019 00:14:12'!
Object subclass: #Cart
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'PB 10/31/2019 00:10:02'!
add: aNumber booksOfISBN: ISBNNumber

	
	(aNumber negative) ifTrue: [^Error signal: self class cannotAddNegativeBooksError].
	contents at: ISBNNumber ifAbsent: [^contents at:ISBNNumber put: aNumber].
	contents at: ISBNNumber put: (contents at: ISBNNumber) + aNumber.
									! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PB 10/30/2019 23:16:15'!
initialize

	contents := Dictionary new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PB 10/30/2019 23:21:50'!
isEmpty
	^contents isEmpty.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'PB 10/31/2019 00:14:08'!
list

	|list|
	list := ''.
	contents keysAndValuesDo: [:aKey :aValue | list := list,(aKey printString),' ',(aValue printString)].
	^list.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'PB 10/31/2019 00:14:12'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'PB 10/30/2019 23:31:43'!
cannotAddNegativeBooksError

	^'You cannot add a negative amount of books'! !
