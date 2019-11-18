!classDefinition: #CartTest category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
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

!CartTest methodsFor: 'tests' stamp: 'PB 11/16/2019 18:30:01'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore).! !

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

!CartTest methodsFor: 'tests' stamp: 'PB 11/16/2019 18:35:56'!
test09ListingAnEmptyCartReturnsEmptyCollection

	| cart |
	
	cart := testObjectsFactory createCart.
	

	self assert: (Dictionary new) equals: cart listItems.! !

!CartTest methodsFor: 'tests' stamp: 'PB 11/16/2019 18:37:34'!
test10ListingANonEmptyCartReturnsItemCollection

	| cart items|
	
	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	items := Dictionary new.
	items at: testObjectsFactory itemSellByTheStore put:1.


	self assert: items equals: cart listItems.! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
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

!CashierTest methodsFor: 'tests' stamp: 'PB 11/16/2019 18:26:19'!
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
		
	self assert: cashier checkOut total = (testObjectsFactory itemSellByTheStorePrice * 2)! !

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

!CashierTest methodsFor: 'tests' stamp: 'PB 11/16/2019 18:52:42'!
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
		
	total := cashier checkOut total.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'PB 11/16/2019 18:53:21'!
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
	total := cashier checkOut total.
					
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


!classDefinition: #InnerInterfaceTest category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
TestCase subclass: #InnerInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InnerInterfaceTest methodsFor: 'setup' stamp: 'st 11/9/2019 11:35:45'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/17/2019 23:19:17'!
createCartList: aBookISBN with: anAmount

	| cartList |

	cartList := Dictionary new.
	cartList at: aBookISBN put: anAmount.
	
	^cartList.! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/17/2019 21:05:03'!
createCartOn: anInnerInterface with: userId and: aPassword thenAdd: aBookISBN amount: anAmount
	
	| cartId |

	cartId _ anInnerInterface createCart: userId with: aPassword.
	anInnerInterface addToCart: cartId withISBN: aBookISBN quantity: anAmount. 
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'PB 11/16/2019 19:20:10'!
test01ListingAnEmptyCartReturnsAnEmptyCollection

	| innerInterface |
	
	innerInterface _ InnerInterface create.
	innerInterface createCart: 1 with: '123456'.
	
	self assert: (Dictionary new) equals: (innerInterface listCart: 1).
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/17/2019 23:19:56'!
test02ListingACartWithOneItemReturnsNonEmptyCollection

	| innerInterface cartItems |
		
	innerInterface _ InnerInterface create.
	self createCartOn: innerInterface with: 1 and: '123456' thenAdd: testObjectsFactory itemSellByTheStore amount: 1.
	
	cartItems _ self createCartList: testObjectsFactory itemSellByTheStore with: 1.	
		
	self assert: cartItems equals: (innerInterface listCart: 1).
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/17/2019 23:20:24'!
test03ListingACartReturnsItsItemsWhileHavingCreatedMoreThanOneCart

	| innerInterface cartItems |
	
	innerInterface _ InnerInterface create.
	self createCartOn: innerInterface with: 1 and: '123456' thenAdd: testObjectsFactory itemSellByTheStore amount: 1.
	self createCartOn: innerInterface with: 1 and: '123456' thenAdd: testObjectsFactory itemSellByTheStore amount: 2.

		
	cartItems _ self createCartList: testObjectsFactory itemSellByTheStore with: 2.
		
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

!InnerInterfaceTest methodsFor: 'tests' stamp: 'PB 11/16/2019 19:22:24'!
test05CreatingACartReturnsEmptyCollection

	| innerInterface |
	
	innerInterface _ InnerInterface create.

	innerInterface createCart: 1 with: '123456'.
	
	self assert: (Dictionary new) equals: (innerInterface listCart: 1).

	
	
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

!InnerInterfaceTest methodsFor: 'tests' stamp: 'PB 11/16/2019 19:22:33'!
test07TryingToCreateACartWithAExistingUserReturnsEmptyCollection

	| innerInterface |
	
	innerInterface _ InnerInterface create.

	innerInterface createCart: 2 with: '1234'.
	self assert: (Dictionary new) equals: (innerInterface listCart: 1).

	
	
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

!InnerInterfaceTest methodsFor: 'tests' stamp: 'PB 11/16/2019 19:22:41'!
test09TryingToCreateACartWithAValidPasswordReturnsEmptyCollection

	| innerInterface |
	
	innerInterface _ InnerInterface create.

	innerInterface createCart: 2 with: '1234'.
	self assert: (Dictionary new) equals: (innerInterface listCart: 1).

	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/17/2019 23:20:42'!
test10AddingAValidItemInACartListsCorrectly

	| innerInterface cartItems|
	
	innerInterface _ InnerInterface create.
	
	self createCartOn: innerInterface with: 2 and: '1234' thenAdd: testObjectsFactory itemSellByTheStore amount: 2.

	cartItems _ self createCartList: testObjectsFactory itemSellByTheStore with: 2.

	self assert: 
	(cartItems) equals: (innerInterface listCart: 1).


	
	
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

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/17/2019 23:16:28'!
test14CheckingOutCartRegistersSales

	| innerInterface creditCard orderedCollection merchantProcessor productsSold|
	creditCard := CreditCard expiringOn: (Date tomorrow).
	merchantProcessor := MerchantProcessorSimulator new.	
		
	innerInterface _ InnerInterface create.
	self createCartOn: innerInterface with: 2 and: '1234' thenAdd: testObjectsFactory itemSellByTheStore amount: 2.
	innerInterface checkOutCart: 1 withCreditCard: creditCard through: merchantProcessor on: (Date today).
	
	orderedCollection := OrderedCollection new.
	productsSold := Dictionary new.
	productsSold at: (testObjectsFactory itemSellByTheStore) put: 2.
	orderedCollection add: (Sale of: productsSold totaling: 20).
	
	self assert:orderedCollection equals: (innerInterface salesBook). 
	


	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/17/2019 23:11:15'!
test15CartCheckOutFailureDoesNotRegisterSales

	| innerInterface creditCard merchantProcessor|
	creditCard := testObjectsFactory expiredCreditCard.
	merchantProcessor := MerchantProcessorSimulator new.	
		
	innerInterface _ InnerInterface create.
	self createCartOn: innerInterface with: 2 and: '1234' thenAdd: testObjectsFactory itemSellByTheStore amount: 2.
	
	
	self should: [innerInterface checkOutCart: 1 withCreditCard: creditCard through: merchantProcessor on: (Date today)]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.].

	self assert: innerInterface salesBook isEmpty. 
	


	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'PB 11/16/2019 17:25:26'!
test16ListingPurchasesOfCustomerWithNoPurchases

	|innerInterface purchaseList|

	innerInterface _ InnerInterface create.
	innerInterface createCart: 1 with: '123456'.

	purchaseList := innerInterface listPurchasesOfClient: 1 withPassword: '123456'.
	self assert: purchaseList purchases isEmpty.
	self assert: 0 equals: purchaseList total. 
	


	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/17/2019 23:21:08'!
test17ListingPurchasesOfCustomerWithPurchasesOfOnlyOneCart

	|innerInterface purchaseList cartList merchantProcessor|

	innerInterface _ InnerInterface create.
	merchantProcessor := MerchantProcessorSimulator new.
	self createCartOn: innerInterface with: 1 and: '123456' thenAdd: testObjectsFactory itemSellByTheStore amount: 1.
	
	
	innerInterface checkOutCart: 1 withCreditCard: testObjectsFactory notExpiredCreditCard through: merchantProcessor on: (Date today).

	purchaseList := innerInterface listPurchasesOfClient: 1 withPassword: '123456'.
	cartList _ self createCartList: testObjectsFactory itemSellByTheStore with: 1.
	
	self assert: cartList equals: purchaseList purchases.
	self assert: 10 equals: purchaseList total. 
	


	
	
	! !

!InnerInterfaceTest methodsFor: 'tests' stamp: 'st 11/17/2019 23:21:22'!
test18ListingPurchasesOfCustomerWithPurchasesDoneInMultipleCarts

	|innerInterface purchaseList cartList merchantProcessor|

	innerInterface _ InnerInterface create.
	merchantProcessor := MerchantProcessorSimulator new.
	self createCartOn: innerInterface with: 1 and: '123456' thenAdd: testObjectsFactory itemSellByTheStore amount: 1.
	innerInterface checkOutCart: 1 withCreditCard: testObjectsFactory notExpiredCreditCard through: merchantProcessor on: (Date today).

	self createCartOn: innerInterface with: 1 and: '123456' thenAdd: testObjectsFactory itemSellByTheStore amount: 2.
	innerInterface checkOutCart: 2 withCreditCard: testObjectsFactory notExpiredCreditCard through: merchantProcessor on: (Date today).

	purchaseList := innerInterface listPurchasesOfClient: 1 withPassword: '123456'.
	cartList _ self createCartList: testObjectsFactory itemSellByTheStore with: 3.
	
	self assert: cartList equals: purchaseList purchases.
	self assert: 30 equals: purchaseList total. 
	


	
	
	! !


!classDefinition: #Cart category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
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


!Cart methodsFor: 'initialization' stamp: 'PB 11/16/2019 17:59:53'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Dictionary new.! !


!Cart methodsFor: 'queries' stamp: 'PB 11/16/2019 18:35:39'!
listItems

	^ items copy.! !

!Cart methodsFor: 'queries' stamp: 'PB 11/16/2019 18:20:02'!
occurrencesOf: anItem

	^items at:anItem.  ! !


!Cart methodsFor: 'testing' stamp: 'PB 11/16/2019 18:19:13'!
includes: anItem

	^items includesKey: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'PB 11/16/2019 18:41:06'!
total

	|total|
	total := 0.
	items keysDo: [:key | total := total + (items at: key) * catalog at: key].
	^total.! !


!Cart methodsFor: 'adding' stamp: 'PB 11/16/2019 18:17:15'!
add: anItem

	self assertIsValidItem: anItem.

	items at: anItem ifAbsent:[^items at: anItem put: 1]. 
	^items at: anItem put: 1 + (items at: anItem). ! !

!Cart methodsFor: 'adding' stamp: 'PB 11/16/2019 18:21:08'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items at: anItem ifAbsent:[^items at: anItem put: aQuantity]. 
	^items at: anItem put: aQuantity + (items at: anItem). ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'PB 11/16/2019 18:41:58'!
createSale

	^ Sale of: (cart listItems) totaling: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'PB 11/16/2019 18:50:26'!
registerSale

	salesBook add: (self createSale)! !


!Cashier methodsFor: 'checkout' stamp: 'PB 11/16/2019 18:51:40'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.
	^self createSale.! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
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


!classDefinition: #CreditCard category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
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

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #InnerInterface category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
Object subclass: #InnerInterface
	instanceVariableNames: 'cartDicc testObjectsFactory lastId users salesBook salesByClient cartsByClient'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InnerInterface methodsFor: 'api' stamp: 'PB 11/16/2019 16:12:11'!
addToCart: aCartId withISBN: anISBN quantity: aQuantity

	 | cart |
	
	 self assertCartExists: aCartId.
	 cart _ cartDicc at: aCartId.
	 cart add: aQuantity of: anISBN.! !

!InnerInterface methodsFor: 'api' stamp: 'PB 11/16/2019 20:27:39'!
checkOutCart: aCartId withCreditCard: aCreditCard through: aMerchantProcessor on: aDate

	| cart cashier sale|
	
	self assertCartExists: aCartId.
	cart _ cartDicc at: aCartId.
	cashier := Cashier toCheckout: cart charging: aCreditCard 
						throught: aMerchantProcessor on: aDate registeringOn: salesBook.
	sale := cashier checkOut.
	self registerSale: sale forClient: (cartsByClient at: aCartId).
	^sale! !

!InnerInterface methodsFor: 'api' stamp: 'st 11/17/2019 23:08:10'!
createCart: aClientId with: aPassword

	self authenticateClient: aClientId with: aPassword.

	cartDicc add: lastId->(testObjectsFactory createCart).
	cartsByClient at: lastId put: aClientId.
	lastId _ lastId + 1.
	
	^ lastId - 1.! !

!InnerInterface methodsFor: 'api' stamp: 'PB 11/16/2019 16:12:11'!
listCart: aCartId

	| cart |
	
	self assertCartExists: aCartId.
	cart _ cartDicc at: aCartId.
	^ cart listItems.! !

!InnerInterface methodsFor: 'api' stamp: 'st 11/17/2019 23:07:56'!
listPurchasesOfClient: aClientId withPassword: aPassword

	self authenticateClient: aClientId with: aPassword.

	
	salesByClient at: aClientId ifAbsent: [salesByClient at: aClientId put: Dictionary new.].
	^self purchaseListFor: aClientId.


	! !


!InnerInterface methodsFor: 'access' stamp: 'PB 11/11/2019 18:28:17'!
salesBook

	^salesBook copy.! !


!InnerInterface methodsFor: 'initialization' stamp: 'PB 11/16/2019 20:06:56'!
initialize

	cartDicc _ Dictionary new.
	testObjectsFactory _ StoreTestObjectsFactory new.
	users _ Dictionary new.
	users add: 1->'123456'; add: 2->'1234'; yourself. 
	lastId _ 1.
	salesBook := OrderedCollection new.
	salesByClient := Dictionary new.
	cartsByClient := Dictionary new.
	! !


!InnerInterface methodsFor: 'assertions' stamp: 'PB 11/16/2019 16:12:11'!
assertCartExists: aCartId

	cartDicc at: aCartId ifAbsent: [self error: InnerInterface nonExistingCartError].! !


!InnerInterface methodsFor: 'as yet unclassified' stamp: 'st 11/17/2019 23:07:29'!
authenticateClient: aClientId with: aPassword

	(users includesKey: aClientId) ifFalse: [self error: InnerInterface nonExistingUserError].
     ((users at: aClientId) = aPassword) ifFalse: [self error: InnerInterface wrongPasswordError].
! !

!InnerInterface methodsFor: 'as yet unclassified' stamp: 'PB 11/16/2019 19:00:26'!
purchaseListFor: aClientId

	^PurchaseList of: (salesByClient at: aClientId)

	
	! !

!InnerInterface methodsFor: 'as yet unclassified' stamp: 'PB 11/16/2019 20:29:41'!
registerSale: aSale forClient: aClientId

	salesByClient at: aClientId ifAbsent:[salesByClient at: aClientId put: OrderedCollection new.].
	(salesByClient at: aClientId) add: aSale.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InnerInterface class' category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
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


!classDefinition: #MerchantProcessorSimulator category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
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


!classDefinition: #PurchaseList category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
Object subclass: #PurchaseList
	instanceVariableNames: 'dicc total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!PurchaseList methodsFor: 'as yet unclassified' stamp: 'PB 11/16/2019 21:52:04'!
createDictionaryFromList: aSaleList

	|allProducts|
	
	allProducts := Dictionary new.
	(aSaleList isEmpty) ifTrue:[^ Dictionary new.].
	aSaleList do: [:sale| |products|  products := sale products.
										products keysDo: [ :key|
											((allProducts includesKey: key ) and: (products includesKey: key)) ifTrue:[allProducts at: key put: ((allProducts at: key) + (products at: key))].
											(((allProducts includesKey: key) not) and: (products includesKey: key)) ifTrue: [allProducts at: key put: (products at: key)].
										].
										].
									
	^allProducts.
	! !

!PurchaseList methodsFor: 'as yet unclassified' stamp: 'PB 11/16/2019 19:34:38'!
initializeWith: aSaleList

	dicc := self createDictionaryFromList: aSaleList.
	aSaleList isEmpty ifTrue: [total := 0. ^self].
	total := aSaleList sum: [:sale | sale total.].! !

!PurchaseList methodsFor: 'as yet unclassified' stamp: 'PB 11/16/2019 19:30:45'!
purchases

	^dicc copy.! !

!PurchaseList methodsFor: 'as yet unclassified' stamp: 'PB 11/16/2019 19:35:07'!
total

	^total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchaseList class' category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
PurchaseList class
	instanceVariableNames: ''!

!PurchaseList class methodsFor: 'as yet unclassified' stamp: 'PB 11/16/2019 19:03:40'!
of: aSaleList

	^self new initializeWith: aSaleList.
	! !


!classDefinition: #Sale category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
Object subclass: #Sale
	instanceVariableNames: 'total productsSold'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'access' stamp: 'PB 11/16/2019 21:42:52'!
products

	^productsSold copy.! !

!Sale methodsFor: 'access' stamp: 'PB 11/16/2019 17:31:12'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'PB 11/16/2019 17:35:37'!
initializeSaleOf: aISBNQuantityDicc totaling: aTotal

	total := aTotal.
	productsSold :=  aISBNQuantityDicc.! !


!Sale methodsFor: 'equality' stamp: 'st 11/17/2019 20:57:04'!
=anotherSale

	^ (total = anotherSale total) and: (self products = anotherSale products).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'PB 11/16/2019 17:36:24'!
of: aISBNQuantityDicc totaling: aTotal

	^self new initializeSaleOf: aISBNQuantityDicc totaling: aTotal
! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'st 11/17/2019 23:22:42'!
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
