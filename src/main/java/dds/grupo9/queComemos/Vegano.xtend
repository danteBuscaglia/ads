package dds.grupo9.queComemos

import java.util.Collection

class Vegano implements CondPreexistente {
	override boolean subsanaCondicion(Collection<Preferencia> gustos, String rutina, float peso){
		gustos.contains(Preferencia.FRUTA)
	} /*Verifica si logra subsanar su condición, para los veganos esto se logra si le gustan las frutas */
    override boolean recetaNoRecomendada(Receta receta){
    	receta.tieneIngrediente("chori") || receta.tieneIngrediente("pollo") || receta.tieneIngrediente("chivito") || receta.tieneIngrediente("carne")
    	
    	
    }

   
   
   
}