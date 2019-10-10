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


!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:16:45'!
test01MarsRoverDoesNotMoveWithEmptyCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover move: ''.
	
	
	self marsRover: marsRover isAtPosition: 0@0 facing: North.
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:18:25'!
test02MovesForwardOnXAxisFacingNorthWithForwardCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover move: 'f'.
	
	self marsRover: marsRover isAtPosition: 0@1 facing: North.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:19:09'!
test03MovesBackwardsOnXAxisFacingNorthWithBackwardsCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover move: 'b'.
	
	self marsRover: marsRover isAtPosition: 0@-1 facing: North.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:21:59'!
test04MovesForwardOnYAxisFacingWestWithForwardCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: West new.
	
	marsRover move: 'f'.
	
	self marsRover: marsRover isAtPosition: (-1@0) facing: West.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:22:43'!
test05MovesBackwardsOnXAxisFacingSouthWithForwardCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: South new.
	
	marsRover move: 'f'.
	
	self marsRover: marsRover isAtPosition: 0@-1 facing: South.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:25:37'!
test06MovesBackwardsOnYAxisFacingEastWithForwardCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: East new.
	
	marsRover move: 'f'.
	
	self marsRover: marsRover isAtPosition: 1@0 facing: East.
	
	
	
! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:26:20'!
test07MovesBackwardsOnXAxisFacingWestWithBackwardsCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: West new.
	
	marsRover move: 'b'.
	
	self marsRover: marsRover isAtPosition: 1@0 facing: West.
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:29:01'!
test08MovesForwardOnXAxisFacingEastWithBackwardsCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: East new.
	
	marsRover move: 'b'.
	
	self marsRover: marsRover isAtPosition: -1@0 facing: East.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:29:37'!
test09MovesForwardOnYAxisFacingSouthWithBackwardsCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: South new.
	
	marsRover move: 'b'.
	
	self marsRover: marsRover isAtPosition: 0@1 facing: South.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:30:18'!
test10FacingNorthRotatesEastWithRotateRightCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover move: 'r'.
	
	
	self marsRover: marsRover isAtPosition: 0@0 facing: East.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:30:54'!
test11FacingWestRotatesNorthWithRotateRigthCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: West new.
	
	marsRover move: 'r'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: North.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:31:32'!
test12FacingSouthRotatesWestWithRotateRightCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: South new.
	
	marsRover move: 'r'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: West.
	
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:31:53'!
test13FacingEastRotatesSouthWithRotateRightCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: East new.
	
	marsRover move: 'r'.
	
	
	self marsRover: marsRover isAtPosition: 0@0 facing: South.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:32:13'!
test14FacingNorthRotatesWestWithRotateLeftCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover move: 'i'.
	
	
	self marsRover: marsRover isAtPosition: 0@0 facing: West.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:32:50'!
test15FacingWestRotatesSouthWithRotateLeftCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: West new.
	
	marsRover move: 'i'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: South.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:33:16'!
test16FacingSouthRotatesEastWithRotatelLeftCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: South new.
	
	marsRover move: 'i'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: East.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:33:37'!
test17FacingEastRotatesNorthWithRotateLeftCommand

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: East new.
	
	marsRover move: 'i'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: North.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:34:54'!
test18MovesForwardMultiplePositionsWithMultipleForwardCommands

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover move: 'fff'.
	
	self marsRover: marsRover isAtPosition: 0@3 facing: North.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:34:41'!
test19MovesBackwardsMultiplePositionsWithMultipleBackwardsCommands

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover move: 'bbb'.
	
	self marsRover: marsRover isAtPosition: 0@-3 facing: North.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:35:59'!
test20RotatesRightMultipleTimesWithMultipleRotateRightCommands

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover move: 'rrr'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: West.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:35:45'!
test21RotatesLeftMultipleTimesWithMultipleRotateLeftCommands

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover move: 'iii'.
	
	self marsRover: marsRover isAtPosition: 0@0 facing: East.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:36:30'!
test22WorksCorrectlyWithMultipleDifferentCommands

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	marsRover move: 'ffr brr   ib'.
	
	
	self marsRover: marsRover isAtPosition: -1@3 facing: South.
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'ST 10/9/2019 11:36:54'!
test23ThrowsErrorWithInvalidCommands

	| marsRover |

	marsRover := MarsRover new.
	marsRover initializeAt: 0@0 facing: North new.
	
	self
		should: [ marsRover move: 'fbfx' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover invalidActionErrorDescription]
	! !
