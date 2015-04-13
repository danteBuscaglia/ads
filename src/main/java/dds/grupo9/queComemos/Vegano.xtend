package dds.grupo9.queComemos

import java.util.Collection

class Vegano extends CondPreexistente {
	override boolean subsanaCondicion(Collection<Preferencia> gustos, String rutina, float peso){
		gustos.contains(Preferencia.FRUTA)
	} /*Verifica si logra subsanar su condición, para los veganos esto se logra si le gustan las frutas */
}