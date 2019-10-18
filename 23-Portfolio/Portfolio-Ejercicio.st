!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 19:03:46'!
test01BalanceOfNewPortfolioShouldBeZero

	|portfolio|
	portfolio := Portfolio new.
	
	self assert: 0 equals: portfolio balance. ! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 19:13:50'!
test02BalanceInPortfolioWithOneAccountShouldBeEqualToAccountBalance

	|portfolio receptiveAccount|
	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.
	Deposit register: 100 on: receptiveAccount.
	portfolio add: receptiveAccount.
	
	self assert: receptiveAccount balance equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 19:30:32'!
test03BalanceInPortfolioWithPortfolioShouldBeEqualToSumOfAllBalances

	|portfolioWithPortfolio portfolio receptiveAccount1 receptiveAccount2|
	
	receptiveAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: receptiveAccount1.
	
	receptiveAccount2 := ReceptiveAccount new.
	Deposit register: 200 on: receptiveAccount2.
	
	portfolio := Portfolio new.
	portfolio add: receptiveAccount1.
	portfolio add: receptiveAccount2.
	
	portfolioWithPortfolio := Portfolio new.
	portfolioWithPortfolio add: portfolio.
	
	self assert: portfolio balance equals:  portfolioWithPortfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 19:29:18'!
test04BalanceInPortfolioWithPortfolioAndAccountsShouldBeEqualToSumOfAllBalances

	|portfolioWithPortfolio portfolio receptiveAccount1 receptiveAccount2 receptiveAccount3|
	
	receptiveAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: receptiveAccount1.
	
	receptiveAccount2 := ReceptiveAccount new.
	Deposit register: 200 on: receptiveAccount2.
	
	receptiveAccount3 := ReceptiveAccount new.
	Deposit register: 300 on: receptiveAccount3.
	
	portfolio := Portfolio new.
	portfolio add: receptiveAccount1.
	portfolio add: receptiveAccount2.
	
	portfolioWithPortfolio := Portfolio new.
	portfolioWithPortfolio add: portfolio.
	portfolioWithPortfolio add: receptiveAccount3.
		
	self assert: (portfolio balance + receptiveAccount3 balance) equals: portfolioWithPortfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 19:44:42'!
test05PortfolioWithAccountFindsTransactionToAccount

	|portfolio receptiveAccount depositTransaction|
	
	receptiveAccount := ReceptiveAccount new.
	depositTransaction := Deposit register: 100 on: receptiveAccount.
	
	portfolio := Portfolio new.
	portfolio add: receptiveAccount.
	
	self assert: true equals: (portfolio hasRegistered: depositTransaction).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 19:47:34'!
test06PortfolioWithPortfolioFindsTransactionToAccount

	|portfolioWithPortfolio portfolio receptiveAccount depositTransaction|
	
	receptiveAccount := ReceptiveAccount new.
	depositTransaction := Deposit register: 100 on: receptiveAccount.
	
	portfolio := Portfolio new.
	portfolio add: receptiveAccount.
	
	portfolioWithPortfolio := Portfolio new.
	portfolioWithPortfolio add: portfolio.
		
	self assert: true equals: (portfolioWithPortfolio hasRegistered: depositTransaction).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 19:49:36'!
test07PortfolioWithPortfolioAndAccountsFindsTransactionToAccounts

	|portfolioWithPortfolio portfolio receptiveAccount1 receptiveAccount2 receptiveAccount3 depositTransaction1 depositTransaction3|
	
	receptiveAccount1 := ReceptiveAccount new.
	depositTransaction1 := Deposit register: 100 on: receptiveAccount1.
	
	receptiveAccount2 := ReceptiveAccount new.
	Deposit register: 200 on: receptiveAccount2.
	
	receptiveAccount3 := ReceptiveAccount new.
	depositTransaction3 := Deposit register: 300 on: receptiveAccount3.
	
	portfolio := Portfolio new.
	portfolio add: receptiveAccount1.
	portfolio add: receptiveAccount2.
	
	portfolioWithPortfolio := Portfolio new.
	portfolioWithPortfolio add: portfolio.
	portfolioWithPortfolio add: receptiveAccount3.
		
	self assert: true equals: (portfolioWithPortfolio hasRegistered: depositTransaction1).
	self assert: true equals: (portfolioWithPortfolio hasRegistered: depositTransaction3).
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 20:16:45'!
test08EmptyPortfolioTransactionsAreEmpty

	|portfolio emptyCollection|
	
	portfolio := Portfolio new.
	emptyCollection := OrderedCollection new.
	
	self assert: emptyCollection equals: (portfolio transactions).
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 20:53:19'!
test09PortfolioWithAccountsHasTheSameTransactionsAsAccounts

	|portfolio receptiveAccount1 receptiveAccount2 totalTransactions|
	
	receptiveAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: receptiveAccount1.
	Deposit register: 200 on: receptiveAccount1.
	Withdraw register: 100 on: receptiveAccount1.
	
	receptiveAccount2 := ReceptiveAccount new.
	Deposit register: 300 on: receptiveAccount2.
	Withdraw register: 500 on: receptiveAccount2.
	Withdraw register: 100 on: receptiveAccount2.
	
	portfolio := Portfolio new.
	portfolio add: receptiveAccount1.
	portfolio add: receptiveAccount2.
	
	totalTransactions := (receptiveAccount1 transactions). 
	totalTransactions addAll: (receptiveAccount2 transactions).
	
	self assert: totalTransactions size equals: ((portfolio transactions) size).
	self assert: totalTransactions asBag equals: ((portfolio transactions) asBag).
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 21:24:30'!
test10PortfolioWithPortfolioAndAccountsHasTheSameTransactionsAsAccounts

	
	self assert: false equals: true.
	
	! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 18:55:44'!
applyToBalance: aBalance
	
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 18:56:27'!
applyToBalance: aBalance

	^aBalance + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'PB 10/17/2019 18:56:51'!
applyToBalance: aBalance

	^aBalance - value.! !

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 19:13:09'!
add: anAccountOrPortfolio

	items add: anAccountOrPortfolio.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 19:06:39'!
balance

	|balance|
	balance := 0.
	items do:[:anItem | balance _ balance + anItem balance. ].
	^balance.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 19:42:37'!
hasRegistered: aTransaction

	|hasTransactionRegistered|
	hasTransactionRegistered := false.
	items do: [:anItem| (anItem hasRegistered: aTransaction) ifTrue: [hasTransactionRegistered := true.]].
	^hasTransactionRegistered.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 19:55:30'!
initialize

	items :=  OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'PB 10/17/2019 20:13:08'!
transactions

	|transactions|
	transactions := OrderedCollection new.
	items do:[:anItem| transactions addAll: (anItem transactions) ]. 
	^transactions.! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'PB 10/17/2019 18:57:56'!
balance

	|balance|
	balance := 0.
	transactions do: [:aTransaction | balance := aTransaction applyToBalance: balance].
	^balance! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
