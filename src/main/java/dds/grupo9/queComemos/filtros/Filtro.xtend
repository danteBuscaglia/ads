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
//		aumentarVecesConsultadasRecetas(decorado.resultado)
		filtrar(decorado.resultado)
	}
	
	def Collection<Receta> filtrar(Collection<Receta> recetas)

/*  def aumentarVecesConsultadasRecetas(Collection<Receta> recetas){
		recetas.forEach[it.aumentarCantidadDeVecesConsultada()]
	}
	
	def recetasMasConsultadas(){
		var Collection<Receta> todasLasRecetas = newHashSet()
		todasLasRecetas.maxBy[receta | receta.cantVecesConsultada]
	}
	
	def recetasMasConsultadasPorSexo(){
		
	}
	
	def veganosDificiles(){
		
	}*/
	   
}

