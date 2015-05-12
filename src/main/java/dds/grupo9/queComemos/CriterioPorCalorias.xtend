package dds.grupo9.queComemos

import java.util.Collection

class CriterioPorCalorias implements CriterioDeOrdenamiento {
	
	override ordenar(Collection<Receta> recetas){
		recetas.sortBy(r|r.calorias)
	}
	
}