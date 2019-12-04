!classDefinition: #ToDictionaryAdapter category: #'TusLibros-Server'!
Object subclass: #ToDictionaryAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ToDictionaryAdapter class' category: #'TusLibros-Server'!
ToDictionaryAdapter class
	instanceVariableNames: ''!

!ToDictionaryAdapter class methodsFor: 'as yet unclassified' stamp: 'PB 11/30/2019 17:05:03'!
adapt: adaptee

	self subclassResponsibility.! !


!classDefinition: #BookListToDictionaryAdapter category: #'TusLibros-Server'!
ToDictionaryAdapter subclass: #BookListToDictionaryAdapter
	instanceVariableNames: 'adaptee'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookListToDictionaryAdapter class' category: #'TusLibros-Server'!
BookListToDictionaryAdapter class
	instanceVariableNames: ''!

!BookListToDictionaryAdapter class methodsFor: 'as yet unclassified' stamp: 'PB 11/30/2019 17:26:06'!
adapt: adaptee

	| adaptedBookList |

  	adaptedBookList _ Set new.  
  
  	adaptee do: [:aBook | adaptedBookList add: (BookToDictionaryAdapter adapt: aBook)].
  
  	^adaptedBookList.! !


!classDefinition: #BookToDictionaryAdapter category: #'TusLibros-Server'!
ToDictionaryAdapter subclass: #BookToDictionaryAdapter
	instanceVariableNames: 'adaptee'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookToDictionaryAdapter class' category: #'TusLibros-Server'!
BookToDictionaryAdapter class
	instanceVariableNames: ''!

!BookToDictionaryAdapter class methodsFor: 'as yet unclassified' stamp: 'PB 11/30/2019 17:06:17'!
adapt: aBook

	|dictionary|
	
	dictionary := Dictionary new.
	dictionary at: 'title' put: aBook title.
	dictionary at: 'ISBN' put: aBook ISBN.
	dictionary at: 'author' put: aBook author.

	^dictionary.
	! !


!classDefinition: #LineItemToDictionaryAdapter category: #'TusLibros-Server'!
ToDictionaryAdapter subclass: #LineItemToDictionaryAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineItemToDictionaryAdapter class' category: #'TusLibros-Server'!
LineItemToDictionaryAdapter class
	instanceVariableNames: ''!

!LineItemToDictionaryAdapter class methodsFor: 'as yet unclassified' stamp: 'PB 11/30/2019 19:12:54'!
adapt: adaptee

	|dictionary|
	
	dictionary := Dictionary new.
	dictionary at: 'item' put: (BookToDictionaryAdapter adapt: (adaptee item)).
	dictionary at: 'quantity' put: adaptee quantity.
	dictionary at: 'total' put: adaptee total.
	^dictionary.! !


!classDefinition: #TicketToDictionaryAdapter category: #'TusLibros-Server'!
ToDictionaryAdapter subclass: #TicketToDictionaryAdapter
	instanceVariableNames: 'adaptee'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicketToDictionaryAdapter class' category: #'TusLibros-Server'!
TicketToDictionaryAdapter class
	instanceVariableNames: ''!

!TicketToDictionaryAdapter class methodsFor: 'as yet unclassified' stamp: 'PB 11/30/2019 19:21:32'!
adapt: aTicket

	|dictionary lineItems|
	
	dictionary := Dictionary new.
	lineItems := Set new.
	(aTicket lineItemsDo: [:lineItem| lineItems add: (LineItemToDictionaryAdapter adapt: lineItem) ]).
	lineItems := lineItems asArray.
	dictionary at: 'lineItems' put: lineItems.
	
	dictionary at: 'total' put: aTicket total.
	
	^dictionary.! !


!classDefinition: #TusLibrosController category: #'TusLibros-Server'!
Object subclass: #TusLibrosController
	instanceVariableNames: 'webServer port tusLibros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'st 12/3/2019 19:47:32'!
addService: aServiceName withParameters: aListOfParameters ofCollaboration: aClosure

	webServer addService: aServiceName action:[:request | |parameters result substringsAsJson username password cart |
		
		[parameters := OrderedCollection new.
		1 to:(aListOfParameters size) do: [:index | parameters add: (request fields at:(aListOfParameters at: index))].
		
		"evaluo el closure con uno o dos parametros"
		((aListOfParameters size) = 1) ifTrue: [result := (aClosure value: (parameters at: 1))].
		((aListOfParameters size) = 2) ifTrue: [result := (aClosure value: (parameters at: 1) value:(parameters at: 2) ).].
		
		(result = tusLibros) ifTrue: [result := 'OK'].	
		result := WebUtils jsonEncode: (result).
		"request send200Response: (substringsAsJson)"
		request send200Response: (result asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].	
			

		! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'PB 12/1/2019 18:02:06'!
addService: aServiceName withParameters: aListOfParameters ofCollaboration: aClosure adaptingWith: anAdapter

	webServer addService: aServiceName action:[:request | |parameters result substringsAsJson username password cart |
		
		[parameters := OrderedCollection new.
		1 to:(aListOfParameters size) do: [:index | parameters at: index put: (request fields at:(aListOfParameters at: index))].
		
		"evaluo el closure con uno o dos parametros"
		result := (aClosure value: (parameters at: 1)).
		result := (anAdapter adapt: result).	
		result := WebUtils jsonEncode: (result).
		"request send200Response: (substringsAsJson)"
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

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'st 12/3/2019 19:59:53'!
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
	ofCollaboration: [:username :password | (tusLibros createCartFor: username authenticatedWith: password) asString].
	
	"webServer addService: '/createCart' action:[:request | |substringsAsJson username password cart |
		
		[username := (request fields at:'username').
		password := (request fields at:'password').
		cart := tusLibros createCartFor: username authenticatedWith: password.
		substringsAsJson:= WebUtils jsonEncode: (cart asString).
		request send200Response: (substringsAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]]."
	
	webServer addService: '/books' action:[:request | | booksAsJson books |
    
	    [
		books := (BookListToDictionaryAdapter adapt: (tusLibros books)).
	     booksAsJson:= WebUtils jsonEncode: (books asArray).
	    
	    "request send200Response: (substringsAsJson)"
	    request send200Response: (booksAsJson asUtf8) 
	         contentType: 'application/json; charset=utf-8' do: [:resp | 
	          resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
	     ] 
	    on: Error 
	    do: [ :anError |
	      request send404Response: (anError messageText) ]].
	
	
	self addService: '/addToCart' 
	withParameters: (OrderedCollection with: 'isbn' with: 'cart') 
	ofCollaboration: [:isbn :cart | tusLibros add: 1 of: (tusLibros getBookByISBN: isbn) toCartIdentifiedAs: (cart asInteger).].
	
	"webServer addService: '/addToCart' action:[:request | | booksAsJson isbn book cartId |
		
		[isbn := (request fields at:'isbn').
		book := (tusLibros getBookByISBN: isbn).
		cartId _ (request fields at:'cart').
		tusLibros add: 1 of: book toCartIdentifiedAs: (cartId asInteger).
		booksAsJson _ 'OK'.
		request send200Response: (booksAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]]."
	
	self addService: '/removeFromCart'  
	withParameters: (OrderedCollection with: 'isbn' with: 'cart') 
	ofCollaboration: [:isbn :cart | tusLibros remove: 1 of: (tusLibros getBookByISBN: isbn) fromCartIdentifiedAs: (cart asInteger).].

		"webServer addService: '/removeFromCart' action:[:request | | booksAsJson isbn book cartId |
		
		[isbn := (request fields at:'isbn').
		book := (tusLibros getBookByISBN: isbn).
		cartId _ (request fields at:'cart').
		tusLibros remove: 1 of: book fromCartIdentifiedAs: (cartId asInteger).
		booksAsJson _ 'OK'.
		request send200Response: (booksAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]]."
	
	self addService: '/numberOfBook' 
	withParameters: (OrderedCollection with: 'isbn' with: 'cart') 
	ofCollaboration: [:isbn :cart | tusLibros numberOfBook: (tusLibros getBookByISBN: isbn) inCartIdentifiedAs: (cart asInteger).].
	
	"webServer addService: '/numberOfBook' action:[:request | | numberOfBook numberOfBooksAsJSON isbn book cartId |
		
		[isbn := (request fields at:'isbn').
		book := (tusLibros getBookByISBN: isbn).
		cartId _ (request fields at:'cart').
		numberOfBook := tusLibros numberOfBook: book inCartIdentifiedAs: (cartId asInteger).
		numberOfBooksAsJSON := WebUtils jsonEncode: (numberOfBook).
		request send200Response: (numberOfBooksAsJSON asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]]."
	
	
		webServer addService: '/typesOfBookInCart' action:[:request | | typesOfBook  typesOfBooksAsJSON cartId |
		
		[cartId _ (request fields at:'cart').
		typesOfBook := BookListToDictionaryAdapter adapt: (tusLibros listBookTypesInCartIdentifiedAs: (cartId asInteger)).
		typesOfBooksAsJSON := WebUtils jsonEncode: (typesOfBook asArray).
		"request send200Response: (substringsAsJson)"
		request send200Response: (typesOfBooksAsJSON asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
	
	
	webServer addService: '/checkoutCart' action:[:request | | ticket ticketAsJSON cartId creditCard|
		
		[cartId _ (request fields at:'cart').
		creditCard := (self userCreditCards) at: (tusLibros getOwnerOfCartIdentifiedAs: (cartId asInteger)).
		ticket := TicketToDictionaryAdapter adapt:(tusLibros checkOutCartIdentifiedAs: (cartId asInteger) 
					withCreditCardNumbered: '1111222233334444' 
					ownedBy: 'Juan' expiringOn: (creditCard expirationMonthOfYear)).
		ticketAsJSON := WebUtils jsonEncode: ticket.
		
		request send200Response: (ticketAsJSON asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
	
	
		webServer addService: '/purchaseHistory' action:[:request | | ticket ticketAsJSON username|
		
		[username := (request fields at:'username').
		ticket := TicketToDictionaryAdapter adapt:(tusLibros purchaseHistoryOfUser: username).
		ticketAsJSON := WebUtils jsonEncode: ticket.
		
		request send200Response: (ticketAsJSON asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
! !

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
