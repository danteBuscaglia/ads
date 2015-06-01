package dds.grupo9.queComemos.filtros

import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.monitoreoDeConsultas.Monitor

abstract class Filtro implements FiltroDecorado {
	
	@Accessors Persona persona
	@Accessors FiltroDecorado decorado
	Collection<Monitor> monitores = newHashSet()
		
	def getPersona(){
		this.persona
	}
	
	override Collection<Receta> resultado() {
//		aumentarVecesConsultadasRecetas(decorado.resultado)
		monitores.forEach[it.update(persona, this.resultado())]
		filtrar(decorado.resultado)
	}
	
	def Collection<Receta> filtrar(Collection<Receta> recetas)


	def agregarMonitor(Monitor monitor){
		monitores.add(monitor)
	}
	
	def eliminarMonitor(Monitor monitor){
		monitores.remove(monitor)
	}
	
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

