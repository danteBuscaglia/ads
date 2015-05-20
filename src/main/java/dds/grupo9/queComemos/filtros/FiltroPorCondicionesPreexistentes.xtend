package dds.grupo9.queComemos.filtros

import java.util.Collection

class FiltroPorCondicionesPreexistentes extends Filtro {
	
	
	override filtrar(Collection<dds.grupo9.queComemos.Receta> recetas){
		var Collection<dds.grupo9.queComemos.Receta> lista = newHashSet()
		lista.addAll(recetas.filter[!persona.recetaNoRecomendada(it)]) 
		lista
	}
	
}