package dds.grupo9.queComemos.ordenamientoResultados

import java.util.Collection
import dds.grupo9.queComemos.Receta

class CriterioPorConsultasDeMujeres implements CriterioDeOrdenamiento {
	
	override Collection<Receta> ordenar(Collection<Receta> recetas){
		recetas.sortBy[it.cantVecesConsultadaPorMujeres].reverse
	}
	
}