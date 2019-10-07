!classDefinition: #MarsRoverTest category: #'MarsRover-Tests'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Tests'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 19:30:32'!
test01MarsRoverNoSeMueveConStringVacio

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $N.
	
	marsRover mover: ''.
	
	self assert: 0@0 equals: marsRover position.
	self assert: $N equals: marsRover facingAt. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 19:59:04'!
test02AvanzaPosicionEnEjeXConFMirandoAlNorte

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $N.
	
	marsRover mover: 'f'.
	
	self assert: 0@1 equals: marsRover position.
	self assert: $N equals: marsRover facingAt.
	
	
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 19:54:36'!
test03RetrocedePosicionEnEjeXConBMirandoAlNorte

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $N.
	
	marsRover mover: 'b'.
	
	self assert: 0@-1 equals: marsRover position.
	self assert: $N equals: marsRover facingAt.
	
	
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 19:59:16'!
test04AvanzaPosicionEnEjeYConFMirandoAlOeste

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $O.
	
	marsRover mover: 'f'.
	
	self assert: 1@0 equals: marsRover position.
	self assert: $O equals: marsRover facingAt.
	
	
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 19:59:25'!
test05RetrocedePosicionEnEjeXConFMirandoAlSur

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $S.
	
	marsRover mover: 'f'.
	
	self assert: 0@-1 equals: marsRover position.
	self assert: $S equals: marsRover facingAt.
	
	
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 19:59:41'!
test06RetrocedePosicionEnEjeYConFMirandoAlEste

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $E.
	
	marsRover mover: 'f'.
	
	self assert: -1@0 equals: marsRover position.
	self assert: $E equals: marsRover facingAt.
	
	
! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 19:52:54'!
test07RetrocedePosicionEnEjeXConBMirandoAlOeste

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $O.
	
	marsRover mover: 'b'.
	
	self assert: -1@0 equals: marsRover position.
	self assert: $O equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 19:57:53'!
test08AvanzaPosicionEnEjeXConBMirandoAlEste

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $E.
	
	marsRover mover: 'b'.
	
	self assert: 1@0 equals: marsRover position.
	self assert: $E equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:11:00'!
test09AvanzaPosicionEnEjeYConBMirandoAlSur

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $S.
	
	marsRover mover: 'b'.
	
	self assert: 0@1 equals: marsRover position.
	self assert: $S equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:11:07'!
test10MirandoAlNorteRotaAOesteAlRecibirUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $N.
	
	marsRover mover: 'r'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: $O equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:13:11'!
test11MirandoAlOesteRotaASurAlRecibirUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $O.
	
	marsRover mover: 'r'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: $S equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:15:50'!
test12MirandoAlSurRotaAlEsteAlRecibirUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $S.
	
	marsRover mover: 'r'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: $E equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:18:54'!
test13MirandoAlEsteRotaAlNorteAlRecibirUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $E.
	
	marsRover mover: 'r'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: $N equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:20:04'!
test14MirandoAlNorteRotaAlEsteAlRecibirUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $N.
	
	marsRover mover: 'i'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: $E equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:22:53'!
test15MirandoAlOesteRotaAlNorteAlRecibirUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $O.
	
	marsRover mover: 'i'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: $N equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:23:17'!
test16MirandoAlSurRotaAlOesteAlRecibirUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $S.
	
	marsRover mover: 'i'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: $O equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:23:38'!
test17MirandoAlEsteRotaAlSurAlRecibirUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $E.
	
	marsRover mover: 'i'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: $S equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:25:34'!
test18AvanzaMultiplesPosicionesAlRecibirMasDeUnaF

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $N.
	
	marsRover mover: 'fff'.
	
	self assert: 0@3 equals: marsRover position.
	self assert: $N equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:48:56'!
test19RetrocedeMultiplesPosicionesAlRecibirMasDeUnaB

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $N.
	
	marsRover mover: 'bbb'.
	
	self assert: 0@-3 equals: marsRover position.
	self assert: $N equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:52:18'!
test20RotarMultiplesVecesAlRecibirMasDeUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $N.
	
	marsRover mover: 'rrr'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: $E equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:53:07'!
test21RotarMultiplesVecesAlRecibirMasDeUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $N.
	
	marsRover mover: 'iii'.
	
	self assert: 0@0 equals: marsRover position.
	self assert: $O equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 20:55:44'!
test22FuncionaCorrectamenteAlRecibirCadenasCompuestas

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $N.
	
	marsRover mover: 'ffr brr   ib'.
	
	self assert: -1@3 equals: marsRover position.
	self assert: $S equals: marsRover facingAt.
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'ST 10/6/2019 21:12:17'!
test23LanzaErrorAlRecibirAccionesInvalidas

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facingAt: $N.
	
	self
		should: [ marsRover mover: 'fbfx' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover invalidActionErrorDescription]
	! !
