package dds.grupo9.queComemos.applicationModels

import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.Receta
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors

class DetalleRecetaAppModel {
	
	Persona logueado = new Persona
	Receta recetaSeleccionada
	Boolean esFavorita
	
	new(Persona persona, Receta receta){
		this.logueado = persona
		this.recetaSeleccionada = receta
		this.esFavorita = persona.recetasFavoritas.contains(receta)
	}
	
	def getAutor(){
		if(recetaSeleccionada.getNombreDueño == logueado.nombre) "Usted"
		else recetaSeleccionada.getNombreDueño
	}
	
}