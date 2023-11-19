
class Plato{
	const nombreDelCocinero
	const baseCalorias = 100
	method cocinero() = nombreDelCocinero
	method cantidadDeAzucar()
	method esBonito()
	method calorias() = 3* self.cantidadDeAzucar() + baseCalorias // punto 1
}

class Entrada inherits Plato{
	override method cantidadDeAzucar() = 0
	override method esBonito() = true
}
class Principal inherits Plato{
	const cantidadDeAzucar
	const esBonito
	override method cantidadDeAzucar() = cantidadDeAzucar
	override method esBonito() = esBonito
}
class Postre inherits Plato{
	const cantidadColores
	override method cantidadDeAzucar() = 120
	override method esBonito() = cantidadColores > 3
}

class Cocinero{
	var especialidad
		
	method cambiarEspecialidad(nuevaEspecialidad){    // punto 3
		especialidad = nuevaEspecialidad
	}
	
	method catar(plato) = especialidad.calificar(plato) // punto 2
	
	method cocinar() = especialidad.cocinar(self) // punto 5
}

class Pastelero{
	const nivelDeseadoDulzor
	method calificar(plato) = (5 * plato.cantidadDeAzucar() / nivelDeseadoDulzor).min(10)
	method cocinar(nombreCocinero) = new Postre(cantidadColores = nivelDeseadoDulzor/50, nombreDelCocinero = nombreCocinero)
}
class Chef{
	const cantidadDeseadaCalorias
	
	method cumpleExpectativas(plato) = plato.esBonito() and plato.calorias()<= cantidadDeseadaCalorias
	method noCumpleExpectativas(plato) = 0
	method calificar(plato){
		if (self.cumpleExpectativas(plato)) (return 10) (return plato.noCumpleExpectativas()) 
	}
	method cocinar(nombreCocinero) = new Principal(cantidadDeAzucar = cantidadDeseadaCalorias, esBonito = true, nombreDelCocinero = nombreCocinero)
}
class SousChef inherits Chef{
	override method noCumpleExpectativas(plato) = (plato.calorias()/100).min(6) // punto 4
	override method cocinar(nombreCocinero) = new Entrada(nombreDelCocinero = nombreCocinero)
}

class Torneo{
	const platosParticipantes = #{}
	const catadores = #{}
	
    // Punto de entrada punto 6a
	method sumarParticipacion(cocinero) {
		platosParticipantes.add(cocinero.cocinar())
	}
	
	// Punto de entrada punto 6b
	method ganador() {
		if (platosParticipantes.isEmpty()) 
			throw new DomainException(message = "No se puede definir el ganador de un torneo sin participantes")
		return platosParticipantes.max({plato => self.calificacionTotal(plato)}).cocinero()
	}
	
	method calificacionTotal(plato) = catadores.sum({catador => catador.catar(plato)})
}