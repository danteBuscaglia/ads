package dds.grupo9.queComemos

import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors

class FiltroPorCaloriasMaximas extends Filtro {
	
	@Accessors int maxSobrepeso
	
	new (int max){
		maxSobrepeso = max
	}
		
	override filtrar (Collection <Receta> recetas){
		if(persona.tieneSobrepeso(maxSobrepeso)){
			var Collection<Receta> lista = newHashSet()
			lista.addAll(recetas.filter[it.calorias < 500]) 
			lista 	
		}
	}
	
}