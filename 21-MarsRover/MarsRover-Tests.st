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


!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 13:58:49'!
test01MarsRoverNoSeMueveConStringVacio

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingNorth new.
	
	marsRover mover: ''.
	
	
	self marsRover: marsRover isAtPosition: 0@0 facing: FacingNorth.
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 13:59:04'!
test02AvanzaPosicionEnEjeXConFMirandoAlNorte

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingNorth new.
	
	marsRover mover: 'f'.
	
	self marsRover: marsRover isAtPosition: 0@1 facing: FacingNorth.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 13:59:16'!
test03RetrocedePosicionEnEjeXConBMirandoAlNorte

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingNorth new.
	
	marsRover mover: 'b'.
	
	self marsRover: marsRover isAtPosition: 0@-1 facing: FacingNorth.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 13:59:29'!
test04AvanzaPosicionEnEjeYConFMirandoAlOeste

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingWest new.
	
	marsRover mover: 'f'.
	
	self marsRover: marsRover isAtPosition: 1@0 facing: FacingWest.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 13:59:41'!
test05RetrocedePosicionEnEjeXConFMirandoAlSur

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingSouth new.
	
	marsRover mover: 'f'.
	
	self marsRover: marsRover isAtPosition: 0@-1 facing: FacingSouth.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 13:59:55'!
test06RetrocedePosicionEnEjeYConFMirandoAlEste

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingEast new.
	
	marsRover mover: 'f'.
	
	self marsRover: marsRover isAtPosition: -1@0 facing: FacingEast.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:00:08'!
test07RetrocedePosicionEnEjeXConBMirandoAlOeste

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingWest new.
	
	marsRover mover: 'b'.
	
	self marsRover: marsRover isAtPosition: -1@0 facing: FacingWest.
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:00:19'!
test08AvanzaPosicionEnEjeXConBMirandoAlEste

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingEast new.
	
	marsRover mover: 'b'.
	
	self marsRover: marsRover isAtPosition: 1@0 facing: FacingEast.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:00:33'!
test09AvanzaPosicionEnEjeYConBMirandoAlSur

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingSouth new.
	
	marsRover mover: 'b'.
	
	self marsRover: marsRover isAtPosition: 0@1 facing: FacingSouth.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:00:44'!
test10MirandoAlNorteRotaAOesteAlRecibirUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingNorth new.
	
	marsRover mover: 'r'.
	
	
	self marsRover: marsRover isAtPosition: 0@0 facing: FacingWest.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:00:57'!
test11MirandoAlOesteRotaASurAlRecibirUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingWest new.
	
	marsRover mover: 'r'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: FacingSouth.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:01:09'!
test12MirandoAlSurRotaAlEsteAlRecibirUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingSouth new.
	
	marsRover mover: 'r'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: FacingEast.
	
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:01:22'!
test13MirandoAlEsteRotaAlNorteAlRecibirUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingEast new.
	
	marsRover mover: 'r'.
	
	
	self marsRover: marsRover isAtPosition: 0@0 facing: FacingNorth.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:01:33'!
test14MirandoAlNorteRotaAlEsteAlRecibirUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingNorth new.
	
	marsRover mover: 'i'.
	
	
	self marsRover: marsRover isAtPosition: 0@0 facing: FacingEast.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:01:41'!
test15MirandoAlOesteRotaAlNorteAlRecibirUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingWest new.
	
	marsRover mover: 'i'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: FacingNorth.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:02:03'!
test16MirandoAlSurRotaAlOesteAlRecibirUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingSouth new.
	
	marsRover mover: 'i'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: FacingWest.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:02:13'!
test17MirandoAlEsteRotaAlSurAlRecibirUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingEast new.
	
	marsRover mover: 'i'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: FacingSouth.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:02:22'!
test18AvanzaMultiplesPosicionesAlRecibirMasDeUnaF

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingNorth new.
	
	marsRover mover: 'fff'.
	
	self marsRover: marsRover isAtPosition: 0@3 facing: FacingNorth.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:02:32'!
test19RetrocedeMultiplesPosicionesAlRecibirMasDeUnaB

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingNorth new.
	
	marsRover mover: 'bbb'.
	
	self marsRover: marsRover isAtPosition: 0@-3 facing: FacingNorth.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:02:47'!
test20RotarMultiplesVecesAlRecibirMasDeUnaR

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingNorth new.
	
	marsRover mover: 'rrr'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: FacingEast.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:02:57'!
test21RotarMultiplesVecesAlRecibirMasDeUnaI

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingNorth new.
	
	marsRover mover: 'iii'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: FacingWest.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 14:03:09'!
test22FuncionaCorrectamenteAlRecibirCadenasCompuestas

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingNorth new.
	
	marsRover mover: 'ffr brr   ib'.
	
	
	self marsRover: marsRover isAtPosition: -1@3 facing: FacingSouth.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/7/2019 13:43:41'!
test23LanzaErrorAlRecibirAccionesInvalidas

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: FacingNorth new.
	
	self
		should: [ marsRover mover: 'fbfx' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover invalidActionErrorDescription]
	! !
