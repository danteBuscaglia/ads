package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.ordenamientoResultados.CriterioDeOrdenamiento

class RecetasMasConsultadas implements Monitor {
	
	var Collection<Receta> recetasConsultadas = newHashSet()
	@Accessors CriterioDeOrdenamiento criterio
	
	override void update(Persona persona, Collection<Receta> recetas){
		recetas.forEach[it.aumentarCantidadDeVecesConsultada()]
		recetasConsultadas.addAll(recetas)
		
	}
	
	def recetasMasConsultadas(int cant){
		var Collection<String> recetasFinal = newHashSet()
		recetasFinal.addAll(recetasConsultadas.sortBy[it.cantVecesConsultada].reverse.take(cant).map[it.getNombre()])
		recetasFinal
	}
	
	
	/*override void update(Persona persona, Collection<Receta> recetas){
		recetas.forEach[receta| 
			if(!recetasConsultadas.exists[r|r.nombre == receta.nombre]){	
				recetasConsultadas.add(receta)
				receta.aumentarCantidadDeVecesConsultada()
			}
			else recetasConsultadas.forEach[r| if(r.nombre == receta.nombre) r.aumentarCantidadDeVecesConsultada()]
		]
	}*/
}