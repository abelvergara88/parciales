class Mensaje {	
	var emisor
	var contenido
	method emisor() = emisor
	method peso() = 5 + contenido.contenido() * 1.3
	
	method contiene(texto) = emisor.contains(texto) or contenido.contiene(texto)
}
// CONTENIDOS
class Texto {
	var elTexto
	method contenido() = elTexto.size()
	method contiene(texto) = elTexto.contains(texto)
}
class Contacto {
	var contacto
	method contacto()= contacto
	method contenido() = 3
	method contiene(texto) = contacto.contains(texto)
}
class Audio {
	var duracion
	method contenido() = duracion * 1.2
	method contiene(texto) = false
}
class Imagen {
	var alto
	var ancho
	var modoCompresion
	method pixeles()=alto*ancho
	method contenido() = modoCompresion.pesoCompresion() * 2
	method contiene(texto) = false
}
class Gifs inherits Imagen{
	var cantidadCuadros
	override method contenido() = super() * cantidadCuadros
}

object compresionOriginal{
	method pesoCompresion(imagen) = imagen.pixeles()
}
class CompresionVariable{
	var porcentaje
	method pesoCompresion(imagen) = imagen.pixeles()*porcentaje/100
}
object compresionMaxima{
	method pesoCompresion(imagen) = (imagen.pixeles()).min(10000)
}

class Chat{
	const participantes = []
	const mensajes = []
	
	method mensajes()= mensajes
	method enviar(mensaje){     // Punto 2 
		self.validarEnvio(mensaje)
		mensajes.add(mensaje)
		self.notificar() // Punto 5a
	}
	method validarEnvio(mensaje) {
		if(!self.puedeEnviar(mensaje))
			throw new Exception(message = "NO se puede enviar un mensaje!!!")
	}
	method tienenEspacioMemoria() = participantes.all({p => p.tieneEspacioMemoria()})
	method pertenceAlChat(alguien) = participantes.contains(alguien)
	method recibir(mensaje) = mensajes.add(mensaje)
	method puedeEnviar(mensaje)= participantes.contains(mensaje.emisor()) and self.tienenEspacioMemoria()
	
	method pesoDelChat()= mensajes.sum({m => m.peso()}) // Punto 1
	
	method contiene(texto) = mensajes.any({m => m.contiene(texto)})
	
	method elMasPesado() = mensajes.max({m => m.peso()})
	
	method notificar() {
		participantes.forEach({usuario => usuario.recibirNotificacion(new Notificacion(chat = self))})
	}	
}
class ChatPremiun inherits Chat{
	var creador
	var restriccion
	method cambiarRestriccion(nuevaRestriccion){ 
		restriccion = nuevaRestriccion
	}
	method agregar(participante){
		participantes.add(participante)
	}
	method eliminar(participante){
		participantes.remove(participante)
	}
	override method puedeEnviar(mensaje)= super(mensaje) and restriccion.puedeEnviar(mensaje, creador)
}
object difusion{
	method puedeEnviar(mensaje, creador)= mensaje.emisor() == creador
}
object reunion{
	method puedeEnviar(mensaje, creador)= true
}
class Ahorro{
	var pesoMax
	method puedeEnviar(mensaje, creador)= mensaje.peso()< pesoMax
}


class Usuario{
	const mensajes = []
	const chats = []
	const notificaciones = []
	
	method agregarChat(chat) { chats.add(chat) }
	
	method guardar(mensaje) = mensajes.add(mensaje)
	
	method memoria() = mensajes.sum({mensaje => mensaje.peso()})
	
	method tieneEspacioMemoria() = self.memoria() <= 500000
	
	method buscar(texto) = chats.filter({mensaje => mensaje.contiene(texto)}) // Punto 3
	
	method elMasPesadoDeCadaChat() = chats.filter({c => c.elMasPesado()}) // Punto 4
	
	method recibirNotificacion(notificacion) { notificaciones.add(notificacion) }
	
	method leer(chat) {												// Punto 5b
		notificaciones.filter({n => n.chat() == chat}).forEach({n => n.leer()})
	}
	
	method notificacionesSinLeer() = notificaciones.filter({n => !n.leida()})    // Punto 5c
}

class Notificacion {
	const property chat
	var property leida = false
	
	method leer() { leida = true }
}