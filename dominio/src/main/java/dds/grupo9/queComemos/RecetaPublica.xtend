package dds.grupo9.queComemos

import dds.grupo9.queComemos.modificacionRecetas.Modificacion
import dds.grupo9.queComemos.excepciones.NoLoTieneException
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import org.uqbar.commons.utils.Observable
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Entity
@Observable
@Accessors
class RecetaPublica implements PrivacidadReceta {
		@Id
		@GeneratedValue
		private Long id
	 Persona creador = new Persona
		
	override puedeVermeOModificarme(Persona persona){
		
		true
	}
	
	override cambiosDeReceta (Persona persona, Modificacion modificacion,Receta receta ){
	
	    var recetaCopia = receta.copiaReceta(persona)
	    persona.agregarReceta(recetaCopia)
	    modificacion.ejecutar(recetaCopia)
	}
	
	override getDueño() {
		creador.nombre = "D10S"
		creador
		//throw new NoLoTieneException("Una receta pública no tiene dueño")
	}
	
	override getNombreDueño() {
		"D10S (Receta Publica)"
	}
	
}