package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta

class RecetasMasConsultadas implements Monitor {
	
	var Collection<Receta> recetasConsultadas
	
	override void update(Persona persona, Collection<Receta> recetas){
		recetas.forEach[it.aumentarCantidadDeVecesConsultada()]
		recetasConsultadas.addAll(recetas)
	}
	
	def recetasMasConsultadas(int cant){
		mostrarRecetasMasConsultadasOrdenadas(recetasConsultadas, cant)
	}
	
	def mostrarRecetasMasConsultadasOrdenadas(Collection<Receta> recetas, int cant){
		recetas.sortBy[it.cantVecesConsultada].reverse.take(cant).map[it.getNombre()]
	}
}