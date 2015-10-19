package dds.grupo9.queComemos.condicionPreexistente

import java.util.Collection
import dds.grupo9.queComemos.Ingrediente
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Persona
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Observable
@Accessors
@Entity
class Vegano implements CondPreexistente {
	@Id
	@GeneratedValue
	private Long id
	var Collection<Ingrediente> ingredientesCarnicos = newHashSet()
	
	new(){
		ingredientesCarnicos.add(new Ingrediente("chori"))
		ingredientesCarnicos.add(new Ingrediente("pollo"))
		ingredientesCarnicos.add(new Ingrediente("chivito"))
		ingredientesCarnicos.add(new Ingrediente("carne"))
		ingredientesCarnicos.add(new Ingrediente("lomo"))
		ingredientesCarnicos.add(new Ingrediente("pescado"))
		ingredientesCarnicos.add(new Ingrediente("marisco"))
		ingredientesCarnicos.add(new Ingrediente("mondongo"))
		ingredientesCarnicos.add(new Ingrediente("lechon"))
		ingredientesCarnicos.add(new Ingrediente("salmon"))
		ingredientesCarnicos.add(new Ingrediente("berberechos"))	
		ingredientesCarnicos.add(new Ingrediente("mejillones"))
		ingredientesCarnicos.add(new Ingrediente("langostinos"))
		ingredientesCarnicos.add(new Ingrediente("bife angosto"))
		ingredientesCarnicos.add(new Ingrediente("jamon"))
	}
	
	@Accessors String nombre = "Vegano"
	
	def agregarAlimentoConCarne(String preferencia){
		ingredientesCarnicos.add(new Ingrediente(preferencia))
	}
	
	override boolean subsanaCondicion(Collection<String> gustos, String rutina, float peso){ /*Verifica si logra subsanar el veganismo, se logra si le gustan las frutas */
		gustos.contains("fruta")
	} 
	
    override boolean recetaNoRecomendada(Receta receta){
    	ingredientesCarnicos.exists[ing | receta.tieneIngrediente(ing.nombre)]
    }
    
    override boolean verificaDatosSegunCondicion(Persona persona){ /* Verifica que el usuario no tenga como preferencia: “pollo�?, “carne�?, “chivito�?, “chori�? */
    	persona.prefiereNoComer(ingredientesCarnicos)
    } 
   
	override boolean esVeganismo(){true}
}