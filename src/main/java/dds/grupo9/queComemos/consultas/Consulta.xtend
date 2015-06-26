package dds.grupo9.queComemos.consultas

import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.Receta

abstract class Consulta implements ConsultaDecorada {
	
	@Accessors Persona persona
	@Accessors ConsultaDecorada decorado
		
	def getPersona(){
		this.persona
	}
	
	override Collection<Receta> resultado() {
		var Collection<Receta> lista = newHashSet()
		lista.addAll(this.filtrar(decorado.resultado)) 
		lista
		//filtrar(decorado.resultado)
	}
	
	def Iterable<Receta> filtrar(Collection<Receta> recetas)
}

