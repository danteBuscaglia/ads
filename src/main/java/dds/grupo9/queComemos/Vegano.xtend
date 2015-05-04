package dds.grupo9.queComemos

import java.util.Collection

class Vegano implements CondPreexistente {
	
	var Collection<Ingrediente> ingredientesCarnicos = newHashSet()
	
	new(){
		ingredientesCarnicos.add(new Ingrediente(Preferencia.CHORI))
		ingredientesCarnicos.add(new Ingrediente(Preferencia.POLLO))
		ingredientesCarnicos.add(new Ingrediente(Preferencia.CHIVITO))
		ingredientesCarnicos.add(new Ingrediente(Preferencia.CARNE))
	}
	
	override boolean subsanaCondicion(Collection<Preferencia> gustos, String rutina, float peso){ /*Verifica si logra subsanar el veganismo, se logra si le gustan las frutas */
		gustos.contains(Preferencia.FRUTA)
	} 
	
    override boolean recetaNoRecomendada(Receta receta){
    	ingredientesCarnicos.exists[ing | receta.tieneIngrediente(ing.nombre)]
    }
    
    override boolean verificaDatosSegunCondicion(Persona persona){ /* Verifica que el usuario no tenga como preferencia: “pollo”, “carne”, “chivito”, “chori” */
    	persona.prefiereNoComer(ingredientesCarnicos)
    } 
   
}