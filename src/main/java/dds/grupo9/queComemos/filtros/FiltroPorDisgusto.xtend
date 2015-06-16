package dds.grupo9.queComemos.filtros

import java.util.Collection
import dds.grupo9.queComemos.Receta

class FiltroPorDisgusto extends Filtro{
	
	
	override filtrar(Collection <Receta> recetas){
		var Collection<Receta> lista = newHashSet()
		lista.addAll(recetas.filter[persona.noContieneIngredientesQueLeDisgusten(it)])
		lista
	}
	
}