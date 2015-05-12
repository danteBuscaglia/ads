package dds.grupo9.queComemos

import java.util.Collection

class FiltroPorDisgusto extends Filtro{
	
	
	override filtrar(Collection <Receta> recetas){
		var Collection<Receta> lista = newHashSet()
		lista.addAll(recetas.filter[it.noContieneIngredientesQueLeDisgustenA(persona)])
		lista
	}
	
}