package dds.grupo9.queComemos

import java.util.Collection

class Vegano implements CondPreexistente {
	
	var Collection<Preferencia> carnes = newHashSet()
	var Collection<Ingrediente> ingredientesCarnicos = newHashSet()
	
	new(){
		carnes.add(Preferencia.POLLO)
		carnes.add(Preferencia.CARNE)
		carnes.add(Preferencia.CHIVITO)
		carnes.add(Preferencia.CHORI)
		ingredientesCarnicos.add(new Ingrediente("chori",0))
		ingredientesCarnicos.add(new Ingrediente("pollo",0))
		ingredientesCarnicos.add(new Ingrediente("chivito",0))
		ingredientesCarnicos.add(new Ingrediente("carne",0))
	}
	
	override boolean subsanaCondicion(Collection<Preferencia> gustos, String rutina, float peso){ /*Verifica si logra subsanar el veganismo, se logra si le gustan las frutas */
		gustos.contains(Preferencia.FRUTA)
	} 
	
    override boolean recetaNoRecomendada(Receta receta){
    	ingredientesCarnicos.exists[ing | receta.tieneIngrediente(ing.nombre)]
    }
    
    override boolean verificaDatosSegunCondicion(Persona persona){ /* Verifica que el usuario no tenga como preferencia: “pollo”, “carne”, “chivito”, “chori” */
    	persona.prefiereNoComer(carnes)
    } 
   
}