package dds.grupo9.queComemos.filtros

import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.Receta

abstract class Filtro implements FiltroDecorado {
	
	@Accessors Persona persona
	@Accessors FiltroDecorado decorado
		
	def getPersona(){
		this.persona
	}
	
	override Collection<Receta> resultado() {
		filtrar(decorado.resultado)
	}
	
	def Collection<Receta> filtrar(Collection<Receta> recetas)
}

