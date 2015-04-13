package dds.grupo9.queComemos

import java.util.Collection

class Celiaco extends CondPreexistente {
			override boolean subsanaCondicion(Collection<Preferencia> gustos, String rutina, float peso){
		true
	} /*Verifica si logra subsanar su condición, para los celíacos siempre se logra */
}