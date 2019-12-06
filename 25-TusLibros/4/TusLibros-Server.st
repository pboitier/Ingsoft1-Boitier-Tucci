!classDefinition: #GenericServerAdapter category: #'TusLibros-Server'!
Object subclass: #GenericServerAdapter
	instanceVariableNames: 'adapterDictionary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!GenericServerAdapter methodsFor: 'as yet unclassified' stamp: 'PB 12/3/2019 23:52:14'!
adapt: adaptee

	(adapterDictionary includesKey: (adaptee class)) ifFalse: [^adaptee].
	^(adapterDictionary at: (adaptee class)) value: adaptee.! !

!GenericServerAdapter methodsFor: 'as yet unclassified' stamp: 'PB 12/4/2019 17:35:26'!
initialize

	adapterDictionary := Dictionary new.
	adapterDictionary at: Book put: [:adaptee| |dictionary|
											dictionary := Dictionary new.
											dictionary at: 'title' put: adaptee title.
											dictionary at: 'ISBN' put: adaptee ISBN.
											dictionary at: 'author' put: adaptee author.
											dictionary.].
										
	adapterDictionary at: Set put: [:set | | adaptedSet |

									  	adaptedSet _ Set new.  
									  	set do: [:anElement | adaptedSet add: (self adapt: anElement)].
									  	(adaptedSet asArray).].
									
	adapterDictionary at: LineItem put: [:lineItem| |dictionary|
												dictionary := Dictionary new.
												dictionary at: 'item' put: (self adapt: (lineItem item)).
												dictionary at: 'quantity' put: lineItem quantity.
												dictionary at: 'total' put: lineItem total.
												dictionary.].
									
	adapterDictionary at: Ticket put: [:ticket| |dictionary lineItems|
											dictionary := Dictionary new.
											lineItems := Set new.
											(ticket lineItemsDo: [:lineItem| lineItems add: (self adapt: lineItem) ]).
											lineItems := lineItems asArray.
											dictionary at: 'lineItems' put: lineItems.
											dictionary at: 'total' put: ticket total.
											dictionary.].! !


!classDefinition: #TusLibrosController category: #'TusLibros-Server'!
Object subclass: #TusLibrosController
	instanceVariableNames: 'webServer port tusLibros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'PB 12/5/2019 21:41:29'!
addService: aServiceName withParameters: aListOfParameters ofCollaboration: aClosure

	webServer addService: aServiceName action:[:request | |parameters result adapter |
		
		[parameters := OrderedCollection new.
		((aListOfParameters size) > 0) ifTrue: [1 to:(aListOfParameters size) do: [:index | parameters add: (request fields at:(aListOfParameters at: index))]].
		
		((aListOfParameters size) = 0) ifTrue: [result := aClosure value.].
		((aListOfParameters size) = 1) ifTrue: [result := (aClosure value: (parameters at: 1))].
		((aListOfParameters size) = 2) ifTrue: [result := (aClosure value: (parameters at: 1) value:(parameters at: 2) ).].
		adapter := GenericServerAdapter new.
		result := (adapter adapt: result).	
		result := WebUtils jsonEncode: (result).
		request send200Response: (result asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].	
			

		! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'st 11/23/2019 11:52:25'!
createSalesBook

	^OrderedCollection new! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'PB 12/3/2019 23:23:37'!
creditCardName

	^'Juan'! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'PB 12/3/2019 23:23:40'!
creditCardNumber

	^'1111222233334444'! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'PB 12/3/2019 23:26:08'!
creditCardOfOwnerOfCart: cartId

	^(self userCreditCards) at: (tusLibros getOwnerOfCartIdentifiedAs: (cartId asInteger))! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'PB 11/30/2019 14:26:55'!
defaultCatalog

	 |book1 book2|
  
	  book1 _ Book withTitle: 'Harry Potter' ISBN: 'ISBN de prueba HP' author: 'Superman'.
	  book2 _ Book withTitle: 'El tunel' ISBN: 'ISBN de prueba el tunel' author: 'Ernesto Sabato'.

	  ^ Dictionary new
	    at: book1 put: 10;
	    at: book2 put: 20;
	    yourself! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'st 11/23/2019 11:23:49'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'PB 12/4/2019 18:55:43'!
initializeWith: aPortNumber

	| clock |
		
	clock := ManualClock now: DateAndTime now.
	tusLibros := TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords
		acceptingItemsOf: self defaultCatalog
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor
		measuringTimeWith: clock.

	port:= aPortNumber.
	
	webServer := WebServer new listenOn: aPortNumber.
	
	self addService: '/createCart' 
	withParameters: (OrderedCollection with: 'username' with: 'password') 
	ofCollaboration: [:username :password | (tusLibros createCartFor: username authenticatedWith: password) asString.].
	
	self addService: '/books'
	withParameters: (OrderedCollection new)
	ofCollaboration: [tusLibros books].
	
	self addService: '/addToCart' 
	withParameters: (OrderedCollection with: 'isbn' with: 'cart') 
	ofCollaboration: [:isbn :cart | tusLibros add: 1 of: (tusLibros getBookByISBN: isbn) toCartIdentifiedAs: (cart asInteger). 'OK'].
	
	self addService: '/removeFromCart'  
	withParameters: (OrderedCollection with: 'isbn' with: 'cart') 
	ofCollaboration: [:isbn :cart | tusLibros remove: 1 of: (tusLibros getBookByISBN: isbn) fromCartIdentifiedAs: (cart asInteger). 'OK'].
	
	self addService: '/numberOfBook' 
	withParameters: (OrderedCollection with: 'isbn' with: 'cart') 
	ofCollaboration: [:isbn :cart | tusLibros numberOfBook: (tusLibros getBookByISBN: isbn) inCartIdentifiedAs: (cart asInteger).].
		
	self addService: '/typesOfBookInCart'
	withParameters: (OrderedCollection with: 'cart')
	ofCollaboration: [:cart | tusLibros listBookTypesInCartIdentifiedAs: (cart asInteger)].
					
	self addService: '/checkoutCart'
	withParameters: (OrderedCollection with: 'cart')
	ofCollaboration: [:cart | tusLibros checkOutCartIdentifiedAs: (cart asInteger) 
						withCreditCardNumbered: (self creditCardNumber)
						ownedBy: (self creditCardName) 
						expiringOn: (self creditCardOfOwnerOfCart: (cart asInteger)) expirationMonthOfYear].
	"adaptingWith: TicketToDictionaryAdapter."	
			
	self addService: '/purchaseHistory'
	withParameters: (OrderedCollection with: 'username')
	ofCollaboration: [:username | tusLibros purchaseHistoryOfUser: username].
	"adaptingWith: TicketToDictionaryAdapter."! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'PB 11/30/2019 18:53:44'!
merchantProcessor

	^MerchantProcessor new.! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'PB 12/1/2019 14:21:02'!
notExpiredCreditCard

	^CreditCard expiringOn: (Month month: (DateAndTime now) monthIndex year: (DateAndTime now) yearNumber + 1).! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'st 11/23/2019 12:13:23'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	"^ port
		ifNil: [port := (10000 to: 50000) atRandom]"
	
	^port ifNil: [port:=8082].
	! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'st 11/23/2019 11:23:49'!
startListening
	
	webServer startListener.

	^ 'Listening on port: ', self port asString.! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'st 11/23/2019 11:23:49'!
stopListening
	
	webServer stopListener.
	
	^'Stopped listening from port: ', self port asString! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'PB 12/1/2019 13:55:50'!
userCreditCards

	|creditCardDictionary|
	
	creditCardDictionary := Dictionary new.
	self validUsersAndPasswords keysDo: [:user |creditCardDictionary at: user put: (self notExpiredCreditCard) ].
	"self invalidUsersAndPasswords keysDo: [:user |creditCardDictionary at: user put: (self expiredCreditCard) ]"
	
	^creditCardDictionary.! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'st 11/23/2019 15:06:22'!
validUsersAndPasswords

	| users |
	
	users _ Dictionary new.
	users add: 'usuario1'->'123456'; add: 'usuario2'->'asdasd'; add: 'usuario3'->'testPassword'; add: 'usuario4'->'prueba'; yourself.
	
	^users.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosController class' category: #'TusLibros-Server'!
TusLibrosController class
	instanceVariableNames: ''!

!TusLibrosController class methodsFor: 'as yet unclassified' stamp: 'st 11/23/2019 12:04:18'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !
