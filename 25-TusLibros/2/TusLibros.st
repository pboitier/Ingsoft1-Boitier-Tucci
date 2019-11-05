!classDefinition: #CartTest category: #TusLibros stamp: 'st 11/4/2019 21:25:18'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'st 11/4/2019 21:02:37'!
test09SubtotalOfEmptyCartIsZero

	| cart |
	
	cart := self createCart.
	
	self assert: 0 equals: cart subtotal.! !

!CartTest methodsFor: 'tests' stamp: 'st 11/4/2019 21:18:56'!
test10SubtotalOfOneItemIsCorrect

	| cart |
	
	cart := self createCart.
	cart add: 'validBook'.
	
	self assert: 100 equals: cart subtotal.! !

!CartTest methodsFor: 'tests' stamp: 'st 11/4/2019 21:20:57'!
test11SubtotalOfMoreThanItemIsCorrect

	| cart |
	
	cart := self createCart.
	cart add: 'validBook'.
	cart add: 'validBook'.
	
	self assert: 200 equals: cart subtotal.! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'st 11/4/2019 21:11:36'!
defaultCatalog
	
	| catalog |

	catalog _ Dictionary new.
	catalog add: 'validBook'->100.	
	
	^catalog.! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'st 11/4/2019 21:25:18'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 20:47:16'!
test01YouCantCheckoutAnEmptyCart

	|cart cashier|
	
	cart _ Cart acceptingItemsOf: (Array with: 'validBook').
	cashier _ Cashier new.
	
	
	self should: [ cashier checkout: cart]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier cannotCheckoutEmptyCartError ].

	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 21:23:14'!
test02CheckingOutASingleItemReturnsTheCorrectAmountOfMoney

	|cart cashier priceList|
	
	priceList _ Dictionary new.
	priceList add: 'validBook' -> 100.		
	cart _ Cart acceptingItemsOf: priceList.
	cashier _ Cashier new.
	
	cart add: 'validBook'.
	
	self assert: 100 equals: (cashier checkout: cart).

	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 21:24:07'!
test03CheckingOutMoreThanOneItemReturnsTheCorrectAmountOfMoney

	|cart cashier priceList|
	
	priceList _ Dictionary new.
	priceList add: 'validBook' -> 100.		
	cart _ Cart acceptingItemsOf: priceList.
	cashier _ Cashier new.
	
	cart add: 'validBook'.
	cart add: 'validBook'.
	
	self assert: 200 equals: (cashier checkout: cart).

	! !


!classDefinition: #Cart category: #TusLibros stamp: 'st 11/4/2019 21:25:18'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'st 11/4/2019 21:13:44'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'st 11/4/2019 21:05:58'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'st 11/4/2019 21:19:40'!
subtotal

	^ items inject: 0
	into: [:subtotal :item | subtotal + (catalog at: item)].! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'st 11/4/2019 21:25:18'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'st 11/4/2019 21:25:18'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 21:24:20'!
checkout: aCart

	(aCart isEmpty) ifTrue: [Error signal: Cashier cannotCheckoutEmptyCartError].
	
	^ aCart subtotal.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'st 11/4/2019 21:25:18'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 20:40:59'!
cannotCheckoutEmptyCartError

	^'Cannot checkout an empty cart'.! !
