package dds.grupo9.queComemos

import java.util.Collection

abstract class CondPreexistente {
		def boolean subsanaCondicion(Collection<Preferencia> gustos, String rutina, float peso) 
		/* Metodo abstracto a redefinir en cada una de las subclases de condicion preexistente*/
}