package dds.grupo9.queComemos

import java.util.Collection

interface CondPreexistente {
	 
	def boolean subsanaCondicion(Collection<Preferencia> gustos, String rutina, float peso) 
		
    def boolean recetaNoRecomendada(Receta receta)

	def boolean verificaDatosSegunCondicion(Persona persona) 
}