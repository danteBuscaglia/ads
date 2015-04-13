package dds.grupo9.queComemos

import java.util.Collection

class Hipertenso extends CondPreexistente {
		override boolean subsanaCondicion(Collection<Preferencia> gustos, String rutina, float peso){
		rutina == "INTENSIVO"
	} /*Verifica si logra subsanar su condición, para los hipertensos esto se logra si tiene una rutina activa intensiva con ejercicio adicional */
}