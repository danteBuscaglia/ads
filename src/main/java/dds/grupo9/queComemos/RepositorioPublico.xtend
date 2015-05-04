package dds.grupo9.queComemos

import java.util.Collection

class RepositorioPublico implements RepositorioDeRecetas {
	
	var Collection <Receta> recetasPublicas = newHashSet()
	def tieneRecetaPublica(String nombreReceta){
		recetasPublicas.exists[it.nombre==nombreReceta]
		
	}
	
	override agregarRecetaPublica(Receta receta){
		recetasPublicas.add(receta)
	}
	
		
	override quitarRecetaPublica(Receta receta){
		if(tieneRecetaPublica(receta.nombre))
		recetasPublicas.remove(receta)
		else throw new NoLoTieneException ("El usuario no contiene esta receta publica")
		
	}
   	
}