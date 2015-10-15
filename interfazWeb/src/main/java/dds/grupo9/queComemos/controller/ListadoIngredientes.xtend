package dds.grupo9.queComemos.controller

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection
import dds.grupo9.queComemos.Receta

@Accessors
class ListadoIngredientes {
	
	Collection<String> ingredientes = newHashSet
	
	new(Collection<Receta> recetas){
		
		this.agregarTodosLosIngredientes(recetas)
	}
	
	def void agregarTodosLosIngredientes(Collection<Receta> recetas) {
		for(receta:recetas){
			ingredientes.addAll(receta.nombreIngredientes)
			
		}
		
	}
	
	
}