package dds.grupo9.queComemos

import java.util.Collection

class RepoRecetas  {
	
	var Collection <Receta> recetasPublicas = newHashSet()
	def tieneRecetaPublica(String nombreReceta){
		recetasPublicas.exists[it.nombre==nombreReceta]
		
	}
	
	def void agregarRecetaPublica(Receta receta){
		
		recetasPublicas.add(receta)
		
	}
	
		
	def quitarRecetaPublica(Receta receta){
		if(tieneRecetaPublica(receta.nombre))
		recetasPublicas.remove(receta)
		else throw new NoLoTieneException ("No existe esta receta publica")
		
	}
	
	def getRecetas(){
		
		this.recetasPublicas
	}
   	
}