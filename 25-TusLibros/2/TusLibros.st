!classDefinition: #CartTest category: #TusLibros stamp: 'PB 11/6/2019 22:04:31'!
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


!classDefinition: #CashierTest category: #TusLibros stamp: 'PB 11/6/2019 22:04:31'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 22:26:51'!
test01YouCantCheckoutAnEmptyCart

	|cart cashier creditCard|
	
	cart _ Cart acceptingItemsOf: (Array with: 'validBook').
	cashier _ Cashier new.
	
	creditCard _ CreditCard with: 1234123123412355 and: (Date newDay: 12 month: #July year: 2200) withOwner: 'peter naborski'.
	
	cashier _ Cashier for: cart with: creditCard on: (Date today).
	
	
	self should: [ cashier checkout]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier cannotCheckoutEmptyCartError ].

	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 22:26:10'!
test02CheckingOutASingleItemReturnsTheCorrectAmountOfMoney

	|cart cashier priceList creditCard|
	
	priceList _ Dictionary new.
	priceList add: 'validBook' -> 100.		
	cart _ Cart acceptingItemsOf: priceList.
	creditCard _ CreditCard with: 1234123123412355 and: (Date newDay: 12 month: #July year: 2200) withOwner: 'peter naborski'.
	
	cashier _ Cashier for: cart with: creditCard on: (Date today).
	
	cart add: 'validBook'.
	
	self assert: 100 equals: (cashier checkout).

	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 22:23:21'!
test03CheckingOutMoreThanOneItemReturnsTheCorrectAmountOfMoney

	|cart cashier priceList creditCard|
	
	priceList _ Dictionary new.
	priceList add: 'validBook' -> 100.		
	cart _ Cart acceptingItemsOf: priceList.
	creditCard _ CreditCard with: 1234123123412355 and: (Date newDay: 12 month: #July year: 2200) withOwner: 'peter naborski'.
	
	cashier _ Cashier for: cart with: creditCard on: (Date today).
	
	cart add: 'validBook'.
	cart add: 'validBook'.
	
	self assert: 200 equals: (cashier checkout).

	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 22:22:39'!
test04CreditCardMustNotBeExpiredForCheckout

	|cart cashier priceList creditCard|
	
	priceList _ Dictionary new.
	priceList add: 'validBook' -> 100.		
	cart _ Cart acceptingItemsOf: priceList.
	cart add: 'validBook'.	
	creditCard _ CreditCard with: 1234123123412355 and: (Date newDay: 12 month: #July year: 1999) withOwner: 'peter naborski'.
	
	
	cashier _ Cashier for: cart with: creditCard on: (Date today).
	
	
	self should: [ cashier checkout ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier cannotCheckoutWithAnExpiredCreditCardError ].! !


!classDefinition: #CreditCardTest category: #TusLibros stamp: 'PB 11/6/2019 22:04:31'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 22:06:58'!
test01CreditCardNumberWithLessThan16DigitsRaisesError

	self should: [ CreditCard with: 123412341234123 and: (Date today) withOwner: 'peter naborski'. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard creditCardNumberMustHave16DigitsError ].! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 22:06:45'!
test02CreditCardNumberWithMoreThan16DigitsRaisesError
	
	self should: [ CreditCard with: 12341234123412345 and: (Date today) withOwner: 'peter naborski'. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
		self assert: anError messageText = CreditCard creditCardNumberMustHave16DigitsError ].! !


!classDefinition: #MerchantProcessorInnerInterfaceTest category: #TusLibros stamp: 'PB 11/6/2019 22:04:31'!
TestCase subclass: #MerchantProcessorInnerInterfaceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorInnerInterfaceTest methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 19:40:20'!
test01CannotDebitFromCardWithOwnerNameLongerThan30Characters

	|merchantProcessor aCreditCard |
	
	merchantProcessor := MerchantProcessor new.
	aCreditCard := CreditCard with: 1234123412341234 and: (Date tomorrow) withOwner: 'Roberto Martin Carlos Alberto Alfonso Dias de la Fuente'.
	self should: [merchantProcessor debitOf: 100 onCard: aCreditCard]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessor creditCardOwnerNameExceedsMaximumLengthError].! !

!MerchantProcessorInnerInterfaceTest methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 19:51:42'!
test02CannotDebitAnAmountWithAWholePartLongerThan15Digits

	|merchantProcessor aCreditCard |
	
	merchantProcessor := MerchantProcessor new.
	aCreditCard := CreditCard with: 1234123412341234 and: (Date tomorrow) withOwner: 'Roberto Carlos'.
	self should: [merchantProcessor debitOf: 1000000000000000000000000 onCard: aCreditCard]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessor wholePartOfamountToDebitExceedsMaximumLengthError.].! !

!MerchantProcessorInnerInterfaceTest methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 21:00:58'!
test03CannotDebitAnAmountWithADecimalPartShorterThan2Digits

	|merchantProcessor aCreditCard |
	
	merchantProcessor := MerchantProcessor new.
	aCreditCard := CreditCard with: 1234123412341234 and: (Date tomorrow) withOwner: 'Roberto Carlos'.
	self should: [merchantProcessor debitOf: 100.2 onCard: aCreditCard]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessor decimalPartOfamountToDebitIsTheWrongLengthError.].! !

!MerchantProcessorInnerInterfaceTest methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 21:01:30'!
test04CannotDebitAnAmountWithADecimalPartLongerThan2Digits

	|merchantProcessor aCreditCard |
	
	merchantProcessor := MerchantProcessor new.
	aCreditCard := CreditCard with: 1234123412341234 and: (Date tomorrow) withOwner: 'Roberto Carlos'.
	self should: [merchantProcessor debitOf: 100.2345 onCard: aCreditCard]
		 raise: Error - MessageNotUnderstood 
		 withExceptionDo: [ :anError |
			self assert: anError messageText = MerchantProcessor decimalPartOfamountToDebitIsTheWrongLengthError.].! !


!classDefinition: #Cart category: #TusLibros stamp: 'PB 11/6/2019 22:04:31'!
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

!classDefinition: 'Cart class' category: #TusLibros stamp: 'PB 11/6/2019 22:04:31'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'PB 11/6/2019 22:04:31'!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 21:58:51'!
checkout

	|merchantProcessor|
	
	(cart isEmpty) ifTrue: [Error signal: Cashier cannotCheckoutEmptyCartError].
	(creditCard isExpiredOn: (Date today)) ifTrue: [Error signal: Cashier cannotCheckoutWithAnExpiredCreditCardError].
	merchantProcessor := MerchantProcessor new.
	merchantProcessor debitOf: (cart subtotal) onCard: creditCard.
	^cart subtotal.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 21:47:42'!
initializeFor: aCart with: aCreditCard on: aDate

	cart _ aCart.
	creditCard _ aCreditCard.
	date _ aDate.	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'PB 11/6/2019 22:04:31'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 20:40:59'!
cannotCheckoutEmptyCartError

	^'Cannot checkout an empty cart'.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 21:49:44'!
cannotCheckoutWithAnExpiredCreditCardError

	^'The credit card that you provided has expired'.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 21:46:43'!
for: aCart with: aCreditCard on: aDate

	^self new initializeFor: aCart with: aCreditCard on: aDate.! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'PB 11/6/2019 22:04:31'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expirationDate ownerName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 22:03:19'!
initializeFor: aCreditCardNumber with: anExpirationDate owner: aName

	self validateNumberLength: aCreditCardNumber.
	
	number _ aCreditCardNumber.
	expirationDate _ anExpirationDate.
	ownerName _ aName.

	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 22:25:52'!
isExpiredOn: aDate

	((expirationDate yearNumber) > (aDate yearNumber)) ifTrue: [^ false].
	((expirationDate monthIndex) > (aDate monthIndex)) ifTrue:[^ false].
	
	^ true.
	
! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 19:40:59'!
ownerName

	^ownerName.
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 22:07:39'!
validateNumberLength: aCreditCardNumber
	
	((aCreditCardNumber asString size) ~=16) ifTrue: [Error signal: CreditCard creditCardNumberMustHave16DigitsError].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'PB 11/6/2019 22:04:31'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 22:01:29'!
creditCardNumberMustHave16DigitsError

	^'Credit card number must have 16 digits'.! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'st 11/4/2019 21:54:26'!
with: aCreditCardNumber and: anExpirationDate withOwner: aName

	^self new initializeFor: aCreditCardNumber with: anExpirationDate owner: aName.! !


!classDefinition: #MerchantProcessor category: #TusLibros stamp: 'PB 11/6/2019 22:04:31'!
Object subclass: #MerchantProcessor
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 21:48:10'!
assertDebitAmountDecimalPartLengthIsCorrect: anAmount

	(((anAmount printString) indexOf: $.) ~= (anAmount printString size - 2)) ifTrue:[Error signal: MerchantProcessor decimalPartOfamountToDebitIsTheWrongLengthError].! !

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 21:47:28'!
assertDebitAmountWholePartLengthIsCorrect: anAmount

	((anAmount printString) size > 15) ifTrue: [Error signal: MerchantProcessor wholePartOfamountToDebitExceedsMaximumLengthError.].! !

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 21:54:27'!
debitOf: anAmount onCard: aCreditCard

	self validateCreditCard: aCreditCard.
	self validateDebitAmount: anAmount.


	
	
	! !

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 21:56:40'!
initialize

	sales := OrderedCollection new.! !

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 21:43:36'!
validateCreditCard: aCreditCard

	((aCreditCard ownerName) size > 30) ifTrue: [Error signal: MerchantProcessor creditCardOwnerNameExceedsMaximumLengthError.].! !

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 21:54:10'!
validateDebitAmount: anAmount

	self assertDebitAmountWholePartLengthIsCorrect: anAmount.
	self assertDebitAmountDecimalPartLengthIsCorrect: anAmount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #TusLibros stamp: 'PB 11/6/2019 22:04:31'!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 19:37:40'!
creditCardOwnerNameExceedsMaximumLengthError
	^'a Credit Card Owner Name cannot exceed 30 characters in length'.! !

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 20:48:17'!
decimalPartOfamountToDebitIsTheWrongLengthError
	^'The decimal part of the amount to debit must be exactly 2 characters in length'.! !

!MerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'PB 11/6/2019 19:53:54'!
wholePartOfamountToDebitExceedsMaximumLengthError
	^'The whole part of the amount to debit cannot exceed 15 characters in length'.! !