package dds.grupo9.queComemos

import java.util.Collection

class Diabetico extends CondPreexistente {
		override boolean subsanaCondicion(Collection<Preferencia> gustos, String rutina, float peso){
		rutina == "ACTIVA" || rutina == "INTENSIVO" || peso < 70
	}/*Verifica si logra subsanar su condición, para los diabeticos se logra si tiene una rutina activa o no pesa mas de 70 kgs */
}