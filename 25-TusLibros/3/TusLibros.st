!classDefinition: #CartTest category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'st 11/9/2019 11:28:34'!
test09ListingAnEmptyCartReturnsEmptyCollection

	| cart |
	
	cart := testObjectsFactory createCart.
	

	self assert: (OrderedCollection new) equals: cart listItems.! !

!CartTest methodsFor: 'tests' stamp: 'st 11/9/2019 11:31:38'!
test10ListingANonEmptyCartReturnsItemCollection

	| cart |
	
	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.

	self assert: (OrderedCollection with: testObjectsFactory itemSellByTheStore) equals: cart listItems.! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'PB 11/11/2019 19:02:56'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	merchantProcessor setDebitBehavior: [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'PB 11/11/2019 19:03:47'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	merchantProcessor setDebitBehavior: [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'PB 11/11/2019 18:56:34'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	merchantProcessor := MerchantProcessorSimulator new.! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'PB 11/11/2019 18:57:09'!
debit: anAmount from: aCreditCard 

	^merchantProcessor debit: anAmount from: aCreditCard.! !


!classDefinition: #InnerInterfaceTest category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
TestCase subclass: #InnerInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InnerInterfaceTest methodsFor: 'setup' stamp: 'st 11/9/2019 11:35:45'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/9/2019 12:47:54'!
test01ListingAnEmptyCartReturnsAnEmptyCollection

	| innerInterface |
	
	innerInterface _ InnerInterface create.
	innerInterface createCart: 1 with: '123456'.
	
	self assert: (OrderedCollection new) equals: (innerInterface listCart: 1).
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/9/2019 12:48:57'!
test02ListingACartWithOneItemReturnsNonEmptyCollection

	| innerInterface cartItems |
		
	innerInterface _ InnerInterface create.
	innerInterface createCart: 1 with: '123456'.
	innerInterface addToCart: 1 withISBN: testObjectsFactory itemSellByTheStore quantity: 1.
	
	cartItems _ OrderedCollection with: testObjectsFactory itemSellByTheStore.
		
	self assert: cartItems equals: (innerInterface listCart: 1).
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/9/2019 12:50:18'!
test03ListingACartReturnsItsItemsWhileHavingCreatedMoreThanOneCart

	| innerInterface cartItems |
	
	innerInterface _ InnerInterface create.
			
	innerInterface _ InnerInterface create.
	innerInterface createCart: 1 with: '123456'.
	innerInterface addToCart: 1 withISBN: testObjectsFactory itemSellByTheStore quantity: 1.
	
	innerInterface createCart: 1 with: '123456'.
	innerInterface addToCart: 2 withISBN: testObjectsFactory itemSellByTheStore quantity: 2.
		
	cartItems _ OrderedCollection with: testObjectsFactory itemSellByTheStore with: testObjectsFactory itemSellByTheStore.
		
	self assert: cartItems equals: (innerInterface listCart: 2).
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/9/2019 12:50:42'!
test04ListingANonExistingCartReturnsError

	| innerInterface |
	
	
	innerInterface _ InnerInterface create.
	
	self 
	should: [ innerInterface listCart: 5 ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = InnerInterface nonExistingCartError.].
	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/9/2019 10:53:36'!
test05CreatingACartReturnsEmptyCollection

	| innerInterface |
	
	innerInterface _ InnerInterface create.

	innerInterface createCart: 1 with: '123456'.
	
	self assert: (OrderedCollection new) equals: (innerInterface listCart: 1).

	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/9/2019 12:03:48'!
test06TryingToCreateACartWithANonExistingUserReturnsError

	| innerInterface |
	
	innerInterface _ InnerInterface create.

	self 
	should: [ innerInterface createCart: 3 with: '123456'. ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = InnerInterface nonExistingUserError.].

	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/9/2019 12:19:37'!
test07TryingToCreateACartWithAExistingUserReturnsEmptyCollection

	| innerInterface |
	
	innerInterface _ InnerInterface create.

	innerInterface createCart: 2 with: '1234'.
	self assert: (OrderedCollection new) equals: (innerInterface listCart: 1).

	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/9/2019 12:11:53'!
test08TryingToCreateACartWithAWrongPasswordReturnsError

	| innerInterface |
	
	innerInterface _ InnerInterface create.

	
	self 
	should: [ innerInterface createCart: 2 with: '123'. ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = InnerInterface wrongPasswordError.].

	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/9/2019 12:14:28'!
test09TryingToCreateACartWithAValidPasswordReturnsEmptyCollection

	| innerInterface |
	
	innerInterface _ InnerInterface create.

	innerInterface createCart: 2 with: '1234'.
	self assert: (OrderedCollection new) equals: (innerInterface listCart: 1).

	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'PB 11/9/2019 17:53:04'!
test10AddingAValidItemInACartListsCorrectly

	| innerInterface |
	
	innerInterface _ InnerInterface create.

	innerInterface createCart: 2 with: '1234'.
	innerInterface addToCart: 1 withISBN: testObjectsFactory itemSellByTheStore quantity: 2. 

	self assert: 
	(OrderedCollection 
		with: testObjectsFactory itemSellByTheStore
		with: testObjectsFactory itemSellByTheStore) equals: (innerInterface listCart: 1).


	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'PB 11/9/2019 18:08:10'!
test11AddingAnInvalidItemInACartReturnsError

	| innerInterface |
	
	innerInterface _ InnerInterface create.

	innerInterface createCart: 2 with: '1234'.
	self 
	should: [ innerInterface addToCart: 1 withISBN: testObjectsFactory itemNotSellByTheStore quantity: 2.  ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = InnerInterface itemNotInCatalogError.].


	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'PB 11/9/2019 17:53:10'!
test12AddingANonExistingCartReturnsError

	| innerInterface |
	
	innerInterface _ InnerInterface create.

	innerInterface createCart: 2 with: '1234'.

	self 
	should: [ innerInterface addToCart: 3 withISBN: testObjectsFactory itemSellByTheStore quantity: 2. ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = InnerInterface nonExistingCartError.].


	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'PB 11/16/2019 14:14:21'!
test13CannotCheckoutANonExistingCart

	| innerInterface creditCard merchantProcessor |
	
	innerInterface _ InnerInterface create.
	innerInterface createCart: 2 with: '1234'.
	creditCard := CreditCard expiringOn: (Date tomorrow).
	merchantProcessor := MerchantProcessorSimulator new.
	
	self should: [innerInterface checkOutCart: 3 withCreditCard: creditCard through: merchantProcessor on: (Date today). ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = InnerInterface nonExistingCartError.].


	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'PB 11/11/2019 19:13:36'!
test14CheckingOutCartRegistersSales

	| innerInterface creditCard orderedCollection merchantProcessor|
	creditCard := CreditCard expiringOn: (Date tomorrow).
	merchantProcessor := MerchantProcessorSimulator new.	
		
	innerInterface _ InnerInterface create.
	innerInterface createCart: 2 with: '1234'.
	innerInterface addToCart: 1 withISBN: testObjectsFactory itemSellByTheStore quantity: 2.
	innerInterface checkOutCart: 1 withCreditCard: creditCard through: merchantProcessor on: (Date today).
	
	orderedCollection := OrderedCollection new.
	orderedCollection add: (Sale of: 20).
	
	self assert:orderedCollection equals: (innerInterface salesBook). 
	


	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'PB 11/16/2019 15:09:25'!
test15CartCheckOutFailureDoesNotRegisterSales

	| innerInterface creditCard merchantProcessor|
	creditCard := testObjectsFactory expiredCreditCard.
	merchantProcessor := MerchantProcessorSimulator new.	
		
	innerInterface _ InnerInterface create.
	innerInterface createCart: 2 with: '1234'.
	innerInterface addToCart: 1 withISBN: testObjectsFactory itemSellByTheStore quantity: 2.
	self should: [innerInterface checkOutCart: 1 withCreditCard: creditCard through: merchantProcessor on: (Date today)]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.].

	self assert: innerInterface salesBook isEmpty. 
	


	
	
	! !


!classDefinition: #Cart category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'st 11/9/2019 11:30:24'!
listItems

	^ items asOrderedCollection.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'PB 11/16/2019 14:52:55'!
assertIsNotExpired: aCreditCard on: aDate
	
	|debugvar|
	(aCreditCard isExpiredOn: aDate) ifTrue: [^self error: self canNotChargeAnExpiredCreditCardErrorMessage ].
	debugvar :=  (aCreditCard isExpiredOn: aDate).! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #InnerInterface category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
Object subclass: #InnerInterface
	instanceVariableNames: 'cartDicc testObjectsFactory lastId users salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InnerInterface methodsFor: 'api' stamp: 'PB 11/9/2019 18:27:51'!
addToCart: aCartId withISBN: anISBN quantity: aQuantity

	 | cart |
	
	 self assertCartExists: aCartId.
	 cart _ cartDicc at: aCartId.
	 cart add: aQuantity of: anISBN.! !

!InnerInterface methodsFor: 'api' stamp: 'PB 11/11/2019 18:37:01'!
checkOutCart: aCartId withCreditCard: aCreditCard through: aMerchantProcessor on: aDate

	| cart cashier|
	
	self assertCartExists: aCartId.
	cart _ cartDicc at: aCartId.
	cashier := Cashier toCheckout: cart charging: aCreditCard 
						throught: aMerchantProcessor on: aDate registeringOn: salesBook.
	^cashier checkOut.! !

!InnerInterface methodsFor: 'api' stamp: 'st 11/9/2019 12:19:30'!
createCart: aClientId with: aPassword

	(users includesKey: aClientId) ifFalse: [self error: InnerInterface nonExistingUserError].
     ((users at: aClientId) = aPassword) ifFalse: [self error: InnerInterface wrongPasswordError].

	cartDicc add: lastId->(testObjectsFactory createCart).
	lastId _ lastId + 1.! !

!InnerInterface methodsFor: 'api' stamp: 'PB 11/9/2019 18:27:24'!
listCart: aCartId

	| cart |
	
	self assertCartExists: aCartId.
	cart _ cartDicc at: aCartId.
	^ cart listItems.! !


!InnerInterface methodsFor: 'access' stamp: 'PB 11/11/2019 18:28:17'!
salesBook

	^salesBook copy.! !


!InnerInterface methodsFor: 'initialization' stamp: 'PB 11/11/2019 18:21:53'!
initialize

	cartDicc _ Dictionary new.
	testObjectsFactory _ StoreTestObjectsFactory new.
	users _ Dictionary new.
	users add: 1->'123456'; add: 2->'1234'; yourself. 
	lastId _ 1.
	salesBook := OrderedCollection new.! !


!InnerInterface methodsFor: 'assertions' stamp: 'PB 11/9/2019 18:26:35'!
assertCartExists: aCartId

	cartDicc at: aCartId ifAbsent: [self error: InnerInterface nonExistingCartError].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InnerInterface class' category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
InnerInterface class
	instanceVariableNames: ''!

!InnerInterface class methodsFor: 'exception' stamp: 'st 11/9/2019 12:40:50'!
itemNotInCatalogError

	^'Item is not in catalog'.! !

!InnerInterface class methodsFor: 'exception' stamp: 'st 11/9/2019 10:48:33'!
nonExistingCartError

	^'The specified cart does not exists'.! !

!InnerInterface class methodsFor: 'exception' stamp: 'st 11/9/2019 12:01:01'!
nonExistingUserCartError

	^'The specified user does not exists'.! !

!InnerInterface class methodsFor: 'exception' stamp: 'st 11/9/2019 12:03:37'!
nonExistingUserError

	^'The specified user does not exists'.! !

!InnerInterface class methodsFor: 'exception' stamp: 'st 11/9/2019 12:12:12'!
wrongPasswordError

	^'Wrong Password'.! !


!InnerInterface class methodsFor: 'initialize' stamp: 'st 11/9/2019 10:39:35'!
create

	^self new initialize.! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'PB 11/11/2019 18:58:14'!
debit: anAmount from: aCreditCard

	^debitBehavior value: anAmount value: aCreditCard.! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'PB 11/11/2019 18:55:14'!
initialize

	debitBehavior := [ :anAmount :aCreditCard | ]! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'PB 11/11/2019 19:03:13'!
setDebitBehavior: aClosure

	debitBehavior := aClosure.! !


!classDefinition: #Sale category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !


!Sale methodsFor: 'as yet unclassified' stamp: 'PB 11/16/2019 14:11:29'!
=anotherSale

	^total = anotherSale total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'PB 11/16/2019 15:26:48'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
