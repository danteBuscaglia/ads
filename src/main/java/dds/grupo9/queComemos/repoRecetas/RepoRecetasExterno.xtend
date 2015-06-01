package dds.grupo9.queComemos.repoRecetas

import queComemos.entrega3.repositorio.RepoRecetas
import org.eclipse.xtend.lib.annotations.Accessors
import queComemos.entrega3.repositorio.BusquedaRecetas
import java.util.Collection
import dds.grupo9.queComemos.RecetaSimple
import dds.grupo9.queComemos.Receta

class RepoRecetasExterno implements dds.grupo9.queComemos.repoRecetas.RepoRecetas {
	
	@Accessors RepoRecetas repositorioExterno
	@Accessors BusquedaRecetas busquedaRecetas
	
	new(){
		val repoExterno = new RepoRecetas()
		this.repositorioExterno = repoExterno
		this.busquedaRecetas = new BusquedaRecetas()
	}
	
	override Collection<Receta> getRecetas() {
		var Collection<Receta> recetas = newHashSet()
		var String resultadoJson
		resultadoJson = repositorioExterno.getRecetas(this.busquedaRecetas)
		recetas.addAll(new RepoExternoAdapter().adaptarJson(resultadoJson))
		recetas = recetas.sortBy[it.nombre]
	}
	
	def Collection<Receta> filterRecetas(BusquedaRecetas busquedaRecetas) {
		var Collection<Receta> recetas = newHashSet()
		for(receta: repositorioExterno.filterRecetas(busquedaRecetas)){
			var RecetaSimple recetaAux = new RecetaSimple(new RepoRecetasPropio)
			recetaAux = new RepoExternoAdapter().adaptarReceta(receta)
			recetas.add(recetaAux)
		}
		recetas = recetas.sortBy[it.nombre]
	}

}