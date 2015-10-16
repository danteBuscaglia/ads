package dds.grupo9.queComemos.controller

import org.eclipse.xtend.lib.annotations.Data
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.Estacion
import queComemos.entrega3.dominio.Dificultad

@Data
@Accessors
class ConsultaReceta {

	Collection<Receta> recetas = newHashSet()
	Collection<Receta> recetasAptas = newHashSet()
	Collection<Receta> recetasBuscadas = newHashSet()
	
	new(Persona persona, RepoRecetasPropio repo){
		this.recetas.addAll(repo.getRecetas)
		this.mapearRecetasAptas(recetasAptas, recetas, persona)
	}
	
	def mapearRecetasAptas(Collection<Receta> recetasAptas, Collection<Receta> recetas, Persona persona) {
		recetasAptas.addAll(recetas.filter[!persona.recetaNoRecomendada(it)])
	}
	
	def filtrarRecetas(String nom, int caloriasMin, int caloriasMax){//, Dificultad dificultad, Estacion temporada, String ing){
		recetasBuscadas.addAll(recetas.filter[it.nombre==nom && it.calorias>caloriasMin && it.calorias<caloriasMax])
			//&& it.dificultad == dificultad && it.temporadasCorrespondientes.contains(temporada) && it.tieneIngrediente(ing)])
	}
	
}