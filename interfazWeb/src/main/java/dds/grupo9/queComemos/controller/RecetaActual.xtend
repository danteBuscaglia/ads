package dds.grupo9.queComemos.controller

import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Persona
import org.eclipse.xtend.lib.annotations.Data

@Data
class RecetaActual {
	
	Persona persona
	Receta recetaActual
	
	new(Persona persona, Receta receta) {
		this.recetaActual = receta
		this.persona = persona	
	}
	
}