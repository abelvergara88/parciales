class Vikingo {
	var castaSocial
	method esProductivo() = castaSocial.permiteSubirExp(self)
}
class Soldado inherits Vikingo{
	var vidasCobradas
	const armas = []
	method tieneArmas() = !armas.isEmpty()
	override method esProductivo() = super() and vidasCobradas > 20 and self.tieneArmas()
	
	
}
class Granjero inherits Vikingo{
	var cantidadHijos
	var cantidadHectareas
	
	override method esProductivo() = super() and self.puedeAlimentarHijos()
	method puedeAlimentarHijos()= 2*cantidadHijos <= cantidadHectareas
	
}
object esclavo{
	method permiteSubirExp(vikingo) = !vikingo.tieneArmas()
}
object castaMedia{
	method permiteSubirExp(vikingo) = true
}
object noblesa{
	method permiteSubirExp(vikingo) = true
}

class Expedicion{
	const vikingos
	const objetivos = []
	
	method cantidadVikingos() = vikingos.size()
	method valeLaPena() = objetivos.all({obj => obj.valeLaPena(self)})
}

class Capital{
	var factorRiqueza
	var cantDefensores
	method botin(expedicion) = cantDefensores.min(expedicion.cantidadVikingos()) * factorRiqueza
	method valeLaPena(expedicion) = expedicion.cantidadVikingos()*3 <= self.botin(expedicion)
}

class Aldea{
	
}















