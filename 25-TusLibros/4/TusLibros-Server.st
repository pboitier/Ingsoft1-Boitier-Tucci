!classDefinition: #TusLibrosController category: #'TusLibros-Server'!
Object subclass: #TusLibrosController
	instanceVariableNames: 'webServer port tusLibros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'st 11/23/2019 11:52:25'!
createSalesBook

	^OrderedCollection new! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'st 11/23/2019 11:51:18'!
defaultCatalog

	^ Dictionary new
		at: 'harryPotter' put: 10;
		at: 'elTunel' put: 20;
		yourself ! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'st 11/23/2019 11:23:49'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosController methodsFor: 'as yet unclassified' stamp: 'st 11/23/2019 19:38:35'!
initializeWith: aPortNumber

	| clock |
		
	clock := ManualClock now: Date today.
	tusLibros := TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords
		acceptingItemsOf: self defaultCatalog
		registeringOn: self createSalesBook
		debitingThrought: self
		measuringTimeWith: clock.

	
	port:= aPortNumber.
	
	webServer := WebServer new listenOn: aPortNumber.
	
	webServer addService: '/createCart' action:[:request | |substringsAsJson username password cart |
		
		[username := (request fields at:'username').
		password := (request fields at:'password').
		cart := tusLibros createCartFor: username authenticatedWith: password.
		substringsAsJson:= WebUtils jsonEncode: (cart asString).
		"request send200Response: (substringsAsJson)"
		request send200Response: (substringsAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
	
		
	webServer addService: '/books' action:[:request | | booksAsJson username password books |
		
		[username := (request fields at:'username').
		password := (request fields at:'password').
		books := tusLibros booksUsing: username authenticatedWith: password.
		booksAsJson:= WebUtils jsonEncode: (books asArray).		
		
		"request send200Response: (substringsAsJson)"
		request send200Response: (booksAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
	
	webServer addService: '/addToCart' action:[:request | | booksAsJson book cartId |
		
		[book _ (request fields at:'book').
		cartId _ (request fields at:'cart').
		tusLibros add: 1 of: book toCartIdentifiedAs: (cartId asInteger).
		booksAsJson _ 'OK'.
		"request send200Response: (substringsAsJson)"
		request send200Response: (booksAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
	

	
! !

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
