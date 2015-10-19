package dds.grupo9.queComemos.condicionPreexistente

import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Ingrediente
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.Receta
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Observable
@Accessors
@Entity
class Diabetico implements CondPreexistente {
	@Id
	@GeneratedValue
	private Long id
	@Accessors int cantidadAzucarPermitida

	new(){
		cantidadAzucarPermitida = 100
	}
	
	@Accessors String nombre = "Diabetico"
	
	override boolean subsanaCondicion(Collection<String> gustos, String rutina, float peso){/* Verifica si logra subsanar su condición, para los diabeticos se logra si tiene una rutina activa o no pesa mas de 70 kgs */
		rutina == "ACTIVA" || rutina == "INTENSIVO" || peso < 70
	}
      
    override recetaNoRecomendada(Receta receta){	
    	receta.tieneMasDeUnaCantidadDe(cantidadAzucarPermitida, new Ingrediente("azucar", 0))        
    }

    override boolean verificaDatosSegunCondicion(Persona persona){ /* Verifica que usuarios diabéticos indiquen el sexo  y al menos una preferencia */
      	persona.indicaSexo && persona.tienePreferencias
    }
    
    override boolean esVeganismo(){false} 
    	
}