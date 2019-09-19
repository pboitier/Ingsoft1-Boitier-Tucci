!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testingHelpMethods' stamp: 'PB 9/2/2019 20:32:46'!
checkErrorConditionAndPerformAnAction: closure errorCondition: error actionOnError: action

	[ closure value.
		self fail ]
		on: error 
		do: action! !

!CustomerBookTest methodsFor: 'testingHelpMethods' stamp: 'PB 9/2/2019 20:36:28'!
customersBookStateCheck: customersBook expectedNumberOfActiveCustomers: customersNumber expectedNumberOfSuspendedCustomers: suspendedCustomersNumber expectedNumberOfCustomers: activeCustomersNumber customer: customer isIncluded: isIncluded

self assert: customersNumber equals: customersBook numberOfActiveCustomers.
self assert: suspendedCustomersNumber equals: customersBook numberOfSuspendedCustomers.
self assert: activeCustomersNumber equals: customersBook numberOfCustomers.
self assert: isIncluded equals: (customersBook includesCustomerNamed: customer).
! !

!CustomerBookTest methodsFor: 'testingHelpMethods' stamp: 'PB 9/2/2019 20:33:18'!
doOperationAndMeasureTime: operation threshold: time
	
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	operation.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < time! !


!CustomerBookTest methodsFor: 'testing' stamp: 'PB 9/2/2019 19:07:28'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.

	self doOperationAndMeasureTime: [customerBook addCustomerNamed: 'John Lennon'.] threshold: 50 * millisecond.

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PB 9/2/2019 19:10:09'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	self doOperationAndMeasureTime: [customerBook removeCustomerNamed: paulMcCartney.] 
										  threshold: 100 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PB 9/2/2019 19:21:29'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self checkErrorConditionAndPerformAnAction: [customerBook addCustomerNamed: ''.]
		 errorCondition: Error
		 actionOnError: [:anError | 
						  self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
						  self assert: customerBook isEmpty]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PB 9/2/2019 19:22:43'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
				
	self checkErrorConditionAndPerformAnAction: [customerBook removeCustomerNamed: 'Paul McCartney'.]
		 errorCondition: NotFound 
		 actionOnError: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]


! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PB 9/2/2019 20:29:51'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
		
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self customersBookStateCheck: customerBook
	 expectedNumberOfActiveCustomers: 0
	 expectedNumberOfSuspendedCustomers: 1
	 expectedNumberOfCustomers: 1
	 customer: paulMcCartney
	 isIncluded: true

	
	
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PB 9/2/2019 20:29:17'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self customersBookStateCheck: customerBook
		 expectedNumberOfActiveCustomers: 0
		 expectedNumberOfSuspendedCustomers: 0
		 expectedNumberOfCustomers: 0
		 customer: paulMcCartney
		 isIncluded: false
	
	
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PB 9/2/2019 19:25:26'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
		
	self checkErrorConditionAndPerformAnAction: [customerBook suspendCustomerNamed: 'Paul McCartney'.]
	 errorCondition: CantSuspend
	 actionOnError: [ :anError | 
		self assert: customerBook numberOfCustomers = 1.
		self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'PB 9/2/2019 19:26:43'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
		
	self checkErrorConditionAndPerformAnAction: [customerBook suspendCustomerNamed: johnLennon.]
	 errorCondition: CantSuspend
	 actionOnError: [ :anError | 
		self assert: customerBook numberOfCustomers = 1.
		self assert: (customerBook includesCustomerNamed: johnLennon) ]

! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'PB 9/8/2019 22:00:00'!
removeCustomerNamed: aName 
 
	(active includes: aName)
		ifTrue: [self removeObject: aName fromCollection: active.]
		ifFalse: [self removeObject: aName fromCollection: suspended.]
! !

!CustomerBook methodsFor: 'customer management' stamp: 'PB 9/8/2019 21:58:48'!
removeObject: anObject fromCollection: aCollection
	
	1 to: aCollection size do: 
	[ :index |
		anObject = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^ anObject 
			] 
	].

	^NotFound signal! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:10'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists.'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty.'! !
