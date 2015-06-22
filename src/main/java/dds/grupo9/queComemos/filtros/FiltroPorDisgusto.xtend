package dds.grupo9.queComemos.filtros

import java.util.Collection
import dds.grupo9.queComemos.Receta

class FiltroPorDisgusto extends Filtro{
	
	
	override filtrar(Collection <Receta> recetas){
		recetas.filter[persona.noContieneIngredientesQueLeDisgusten(it)]
	}
	
}