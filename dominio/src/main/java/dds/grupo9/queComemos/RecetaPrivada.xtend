package dds.grupo9.queComemos

import dds.grupo9.queComemos.modificacionRecetas.Modificacion
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Entity
@Accessors
@Observable
class RecetaPrivada implements PrivacidadReceta {
	@Id
	@GeneratedValue
	private Long id
	static Persona creador /* Creador de la receta */

	new(Persona persona) {
		creador = persona
	}

	override puedeVermeOModificarme(Persona persona) {
		persona.comparteGrupoCon(creador) || persona == creador
	}

	override cambiosDeReceta(Persona persona, Modificacion modificacion, Receta receta) {
		modificacion.ejecutar(receta)
	}

	override getDueño() {
		creador
	}

	override getNombreDueño() {
		this.getDueño.nombre
	}

}
