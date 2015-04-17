package dds.grupo9.queComemos

import java.util.Collection

class Celiaco implements CondPreexistente {
	
	override boolean subsanaCondicion(Collection<Preferencia> gustos, String rutina, float peso){true}
	
	override boolean recetaNoRecomendada(Receta receta){false}
	
    override boolean verificaDatosSegunCondicion(Persona persona){true}			
}
