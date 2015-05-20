package dds.grupo9.queComemos

import dds.grupo9.queComemos.modificacionRecetas.Modificacion

class RecetaPublica implements PrivacidadReceta {
	
	
	
	
	override puedeVermeOModificarme(Persona persona){
		
		true
	}
	
	override cambiosDeReceta (Persona persona, Modificacion modificacion,Receta receta ){
	
	    var recetaCopia = receta.copiaReceta(persona)
	    persona.agregarReceta(recetaCopia)
	    modificacion.ejecutar(recetaCopia)
	}
}