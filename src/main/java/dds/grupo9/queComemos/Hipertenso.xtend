package dds.grupo9.queComemos

import java.util.Collection

class Hipertenso implements CondPreexistente {
		override boolean subsanaCondicion(Collection<Preferencia> gustos, String rutina, float peso){
		rutina == "INTENSIVO"
	} /*Verifica si logra subsanar su condición, para los hipertensos esto se logra si tiene una rutina activa intensiva con ejercicio adicional */

       override boolean recetaNoRecomendada(Receta receta){
        receta.tieneIngrediente("sal") || receta.tieneIngrediente("caldo")
       }
       
       override boolean verificaDatosSegunCondicion(Persona persona){/* Verifica que usuarios hipertensos indiquen al menos una preferencia */
       	persona.tienePreferencias
       }
       
}