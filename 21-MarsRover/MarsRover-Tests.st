!classDefinition: #MarsRoverTest category: #'MarsRover-Tests'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Tests'!

!MarsRoverTest methodsFor: 'assert' stamp: 'ST 10/7/2019 13:58:49'!
marsRover: aMarsRover isAtPosition: aPosition facing: aCardinalPoint

	self assert: aPosition equals: aMarsRover position.
	self assert: (aMarsRover facing isKindOf: aCardinalPoint). ! !


!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:01'!
test01MarsRoverNoSeMueveConStringVacio

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover mover: ''.
	
	
	self marsRover: marsRover isAtPosition: 0@0 facing: North.
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:01'!
test02AvanzaPosicionEnEjeXConFMirandoAlNorte

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover mover: 'f'.
	
	self marsRover: marsRover isAtPosition: 0@1 facing: North.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:01'!
test03RetrocedePosicionEnEjeXConBMirandoAlNorte

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover mover: 'b'.
	
	self marsRover: marsRover isAtPosition: 0@-1 facing: North.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:11'!
test04AvanzaPosicionEnEjeYConFMirandoAlOeste

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: West new.
	
	marsRover mover: 'f'.
	
	self marsRover: marsRover isAtPosition: 1@0 facing: West.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:25'!
test05RetrocedePosicionEnEjeXConFMirandoAlSur

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: South new.
	
	marsRover mover: 'f'.
	
	self marsRover: marsRover isAtPosition: 0@-1 facing: South.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:20:47'!
test06RetrocedePosicionEnEjeYConFMirandoAlEste

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: East new.
	
	marsRover mover: 'f'.
	
	self marsRover: marsRover isAtPosition: -1@0 facing: East.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:11'!
test07RetrocedePosicionEnEjeXConBMirandoAlOeste

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: West new.
	
	marsRover mover: 'b'.
	
	self marsRover: marsRover isAtPosition: -1@0 facing: West.
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:20:47'!
test08AvanzaPosicionEnEjeXConBMirandoAlEste

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: East new.
	
	marsRover mover: 'b'.
	
	self marsRover: marsRover isAtPosition: 1@0 facing: East.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:25'!
test09AvanzaPosicionEnEjeYConBMirandoAlSur

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: South new.
	
	marsRover mover: 'b'.
	
	self marsRover: marsRover isAtPosition: 0@1 facing: South.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:40:22'!
test10MirandoAlNorteRotaAEsteAlRecibirUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover mover: 'r'.
	
	
	self marsRover: marsRover isAtPosition: 0@0 facing: East.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:41:08'!
test11MirandoAlOesteRotaANorteAlRecibirUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: West new.
	
	marsRover mover: 'r'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: North.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:25'!
test12MirandoAlSurRotaAlEsteAlRecibirUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: South new.
	
	marsRover mover: 'r'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: East.
	
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:41:49'!
test13MirandoAlEsteRotaAlSurAlRecibirUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: East new.
	
	marsRover mover: 'r'.
	
	
	self marsRover: marsRover isAtPosition: 0@0 facing: South.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:42:16'!
test14MirandoAlNorteRotaAlOesteAlRecibirUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover mover: 'i'.
	
	
	self marsRover: marsRover isAtPosition: 0@0 facing: West.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:42:49'!
test15MirandoAlOesteRotaAlSurAlRecibirUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: West new.
	
	marsRover mover: 'i'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: South.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:25'!
test16MirandoAlSurRotaAlOesteAlRecibirUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: South new.
	
	marsRover mover: 'i'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: West.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:43:53'!
test17MirandoAlEsteRotaAlNorteAlRecibirUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: East new.
	
	marsRover mover: 'i'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: North.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:01'!
test18AvanzaMultiplesPosicionesAlRecibirMasDeUnaF

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover mover: 'fff'.
	
	self marsRover: marsRover isAtPosition: 0@3 facing: North.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:01'!
test19RetrocedeMultiplesPosicionesAlRecibirMasDeUnaB

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover mover: 'bbb'.
	
	self marsRover: marsRover isAtPosition: 0@-3 facing: North.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:01'!
test20RotarMultiplesVecesAlRecibirMasDeUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover mover: 'rrr'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: East.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:11'!
test21RotarMultiplesVecesAlRecibirMasDeUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover mover: 'iii'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: West.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:25'!
test22FuncionaCorrectamenteAlRecibirCadenasCompuestas

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover mover: 'ffr brr   ib'.
	
	
	self marsRover: marsRover isAtPosition: -1@3 facing: South.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'PB 10/8/2019 20:21:01'!
test23LanzaErrorAlRecibirAccionesInvalidas

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	self
		should: [ marsRover mover: 'fbfx' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover invalidActionErrorDescription]
	! !
