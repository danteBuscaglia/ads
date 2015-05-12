package dds.grupo9.queComemos

import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors

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

	def obtenerLosDiezPrimeros(){
		this.resultado.take(10)
	}
	
	def considerarSoloLosResultadosPares(){
		this.resultado.toArray()
	}
	
	def ordenarLosResultados(CriterioDeOrdenamiento criterio){
		criterio.ordenar(this.resultado)
	}
	
}