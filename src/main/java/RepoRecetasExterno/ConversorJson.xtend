package RepoRecetasExterno

import queComemos.entrega3.repositorio.RepoRecetas
import org.eclipse.xtend.lib.annotations.Accessors
import queComemos.entrega3.repositorio.BusquedaRecetas
import java.util.Collection
import dds.grupo9.queComemos.RecetaSimple
import dds.grupo9.queComemos.RepoRecetasPropio
import dds.grupo9.queComemos.Receta

// Es correcto traer esta receta y no la nuestra? Trabajamos con el dominio impuesto

class ConversorJson {
	
	@Accessors RepoRecetas repositorioExterno
	
	new(){
		val repoExterno = new RepoRecetas()
		repoExterno.crearRepoRecetas
		this.repositorioExterno = repoExterno
	}
	
	def Collection<Receta> getRecetas(BusquedaRecetas busquedaRecetas) {
		var Collection<Receta> recetas = newHashSet()
		var String resultadoJson
		resultadoJson = repositorioExterno.getRecetas(busquedaRecetas)
		recetas.addAll(new RepoExternoAdapter().adaptarJson(resultadoJson))
		recetas
	}
	
	def Collection<Receta> filterRecetas(BusquedaRecetas busquedaRecetas) {
		var Collection<Receta> recetas = newHashSet()
		for(receta: repositorioExterno.filterRecetas(busquedaRecetas)){
			var RecetaSimple recetaAux = new RecetaSimple(new RepoRecetasPropio)
			recetaAux = new RepoExternoAdapter().adaptarReceta(receta)
			recetas.add(recetaAux)
		}
		recetas
	}

}