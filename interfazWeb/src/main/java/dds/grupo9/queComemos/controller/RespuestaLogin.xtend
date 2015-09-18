package dds.grupo9.queComemos.controller

import org.eclipse.xtend.lib.annotations.Data
import dds.grupo9.queComemos.Persona

@Data
class RespuestaLogin {
	String nombre
	
	new(Persona persona) {
		nombre = persona.nombre
	}
	
}