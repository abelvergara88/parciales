class Personaje {
	var property copas = 0
}

class Arquero inherits Personaje{
	const agilidad
	const rango 
	
	method destreza()= agilidad * rango
	method tieneEstrategia()= rango > 100
}

class Guerrero inherits Personaje{
	const fuerza
	const tieneEstrategia
	
	method tieneEstrategia()= tieneEstrategia
	method destreza()= fuerza* 1.5
}

class Ballestero inherits Arquero{
	override method destreza()= super()*2
}

class Mision{
	var tipoDeMision = normal
	method copas()
	method puedeSuperarse() // Punto 1
	method cantidadDeCopasFinal()= tipoDeMision.modCopas(self)
	method sumarOrestar() = if(self.puedeSuperarse()) 1 else -1
	
	
	method realizar() {  // Punto 2
		self.validarRealizacion()
		self.repartirCopas()
	}
	method validarRealizacion() {
		if(!self.puedeRealizarse())
			throw new Exception(message = "Misión no puede comenzar")
	}
	
	method puedeRealizarse()
	method repartirCopas() 
}
class MisionIndividual inherits Mision{
	var property participante
	const dificultad
	
	override method copas()= (2* dificultad)
	override method puedeSuperarse() = participante.tieneEstrategia() || participante.destreza() > dificultad
	method cantParticipantes()= 1
	
	override method puedeRealizarse() = participante.copas() >= 10
	override method repartirCopas() {
		participante.darCopas(self.copas()*self.sumarOrestar())
	}
}
class MisionEquipo inherits Mision{
	const participantes = []
	override method copas()= 50 / self.cantParticipantes()
	method cantParticipantes()= participantes.size()
	
	override method puedeSuperarse() = self.masDeLaMitadTienenEstrategia() || self.tienenMuchaDestreza()
	
	method masDeLaMitadTienenEstrategia()= self.cantidadConEstrategia() > self.cantParticipantes()/2
	method cantidadConEstrategia()= participantes.sum({participante => participante.tieneEstrategia()})
	
	method tienenMuchaDestreza()= participantes.all({participante => participante.destreza()>400})	

	override method puedeRealizarse() = participantes.sum{p=>p.copas()} >= 60
	
	override method repartirCopas() {
		participantes.forEach{p=>p.darCopas(self.copas()*self.sumarOrestar())}
	}
}
// Punto 3
object normal{
	method modCopas(mision) = mision.copas()
}
object bonus{
	method modCopas(mision) = mision.copas()+ mision.cantParticipantes()
}
class Boost{
	var property multiplicador
	method modCopas(mision) = mision.copas()* multiplicador
}


