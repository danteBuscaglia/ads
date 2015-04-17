package dds.grupo9.queComemos

import java.util.Collection

class Vegano implements CondPreexistente {
	    var Collection<Preferencia> carnes = newHashSet()
	
	new(){
		carnes.add(Preferencia.POLLO)
		carnes.add(Preferencia.CARNE)
		carnes.add(Preferencia.CHIVITO)
		carnes.add(Preferencia.CHORI)
	}
	override boolean subsanaCondicion(Collection<Preferencia> gustos, String rutina, float peso){ /*Verifica si logra subsanar el veganismo, se logra si le gustan las frutas */
		gustos.contains(Preferencia.FRUTA)
	} 
	
    override boolean recetaNoRecomendada(Receta receta){
    	receta.tieneIngrediente("chori") || receta.tieneIngrediente("pollo") || receta.tieneIngrediente("chivito") || receta.tieneIngrediente("carne")
    	
    }
    override boolean verificaDatosSegunCondicion(Persona persona){ /* Verifica que el usuario no tenga como preferencia: “pollo”, “carne”, “chivito”, “chori” */
    	persona.prefiereNoComer(carnes)
    } 
   
}