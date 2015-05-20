package dds.grupo9.queComemos.filtros

import java.util.Collection

class FiltroPorDisgusto extends Filtro{
	
	
	override filtrar(Collection <dds.grupo9.queComemos.Receta> recetas){
		var Collection<dds.grupo9.queComemos.Receta> lista = newHashSet()
		lista.addAll(recetas.filter[it.noContieneIngredientesQueLeDisgustenA(persona)])
		lista
	}
	
}