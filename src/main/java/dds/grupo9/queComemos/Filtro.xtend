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

	def Receta resultadoEnPosicionXLuegoDeOrdenarPor(int posicion, CriterioDeOrdenamiento criterio){
		(criterio.ordenar(this.resultado).drop(posicion-1)).head
	}

	def obtenerLosDiezPrimeros(){
		this.resultado.take(10)
	}
	
	def considerarSoloLosResultadosPares(){
		var recetasPares = newHashSet()
		var i = 0
		for(receta:this.resultado){
			if(i%2==0)
				recetasPares.add(receta)
			i++
		}
		recetasPares
	}
	
	def ordenarLosResultados(CriterioDeOrdenamiento criterio){
		criterio.ordenar(this.resultado)
	}
	
}