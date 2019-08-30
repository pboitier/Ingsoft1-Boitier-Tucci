import time
from enum import Enum

class Direccion(Enum):
    SIN_DIRECCION = 1
    AGUJAS_DEL_RELOJ = 2
    CONTRA_AGUJAS_DEL_RELOJ = 3

class Suelo:
    def __init__(self, porosidad, dureza):
        self.porosidad = porosidad
        self.dureza = dureza

class Paso:
    def __init__(self, direccion, rpm, tiempo):
        self.direccion = direccion
        self.rpm = rpm
        self.tiempo = tiempo

class BrazoExcavador:
    def __init__(self, sueloInicial, pasos):
        self._sueloActual = sueloInicial
        self._catalogoDeSuelos = {}
        self._catalogoDeSuelos[sueloInicial] = pasos
        self._rpm = 0
        self._direccion = Direccion.SIN_DIRECCION
        self._pinzaAbierta = True

    def __girar(self, direccion, rpm, tiempo):
        _rpm = rpm
        _direccion = direccion
        #Para simular el tiempo que está girando.
        time.sleep(tiempo * 60) 
        _rpm = 0
        _direccion = Direccion.SIN_DIRECCION

    def __abrirPinza(self):
        _pinzaAbierta = True

    def __cerrarPinza(self):
        _pinzaAbierta = False

    def agregarSuelo(self, suelo, pasos):
        self._catalogoDeSuelos[suelo] = pasos

    #Por ahora todas las muestras se analizan en 2 pasos, cerrando la
    #pinza en el medio. Esto podría cambiar para diferentes tipos de suelo.
    def tomarMuestra(self, suelo):
        pasos = self._catalogoDeSuelos[suelo]
        self.__girar(pasos[0].direccion, pasos[0].rpm, pasos[0].tiempo)
        self.__cerrarPinza()
        self.__girar(pasos[1].direccion, pasos[1].rpm, pasos[1].tiempo)
        self.__abrirPinza()

sueloDePiedra = Suelo(0.8, 0.8)
sueloDePolvo = Suelo(0.3, 0.3)
pasosSueloDePiedra = [Paso(Direccion.AGUJAS_DEL_RELOJ, 150, 10), Paso(Direccion.CONTRA_AGUJAS_DEL_RELOJ, 150, 10)]
pasosSueloDePolvo = [Paso(Direccion.CONTRA_AGUJAS_DEL_RELOJ, 100, 5), Paso(Direccion.AGUJAS_DEL_RELOJ, 150, 5)]
brazo = BrazoExcavador(sueloDePiedra, pasosSueloDePiedra)
brazo.agregarSuelo(sueloDePolvo, pasosSueloDePolvo)
brazo.tomarMuestra(sueloDePiedra)

#Adicion del tercer tipo de suelo
sueloIntermedio = Suelo(0.5,0.5)
pasosSueloIntermedio = [Paso(Direccion.AGUJAS_DEL_RELOJ, 150, 5), Paso(Direccion.CONTRA_AGUJAS_DEL_RELOJ, 150, 10)]
brazo.agregarSuelo(sueloIntermedio, pasosSueloIntermedio)

