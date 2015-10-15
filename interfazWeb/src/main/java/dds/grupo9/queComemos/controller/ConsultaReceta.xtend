package dds.grupo9.queComemos.controller

import org.eclipse.xtend.lib.annotations.Data
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio
import dds.grupo9.queComemos.Persona

@Data
@Accessors
class ConsultaReceta {

	@Accessors Collection<Receta> recetas = newHashSet()
	@Accessors Collection<Receta> recetasAptas = newHashSet()
	
	new(Persona persona, RepoRecetasPropio repo){
		this.recetas.addAll(repo.getRecetas)
		this.mapearRecetasAptas(recetasAptas, recetas, persona)
	}
	
	def mapearRecetasAptas(Collection<Receta> recetasAptas, Collection<Receta> recetas, Persona persona) {
		recetasAptas.addAll(recetas.filter[!persona.recetaNoRecomendada(it)])
	}
	
}