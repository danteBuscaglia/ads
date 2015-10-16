package dds.grupo9.queComemos.controller

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection
import dds.grupo9.queComemos.repoRecetas.RepoRecetasEjemplo
import dds.grupo9.queComemos.Receta

@Accessors
class RecetasFiltradas {
	
	Collection<Receta> recetasRepo
	Collection <String> recetasFiltradas
	
	new(RepoRecetasEjemplo repoRecetas){
		recetasRepo.add(repoRecetas.receta1)
		recetasRepo.add(repoRecetas.receta2)
        recetasRepo.add(repoRecetas.receta3)
        recetasRepo.add(repoRecetas.receta4)
        recetasRepo.add(repoRecetas.receta5)
        recetasRepo.add(repoRecetas.receta6)
        recetasRepo.add(repoRecetas.receta7)
        recetasRepo.add(repoRecetas.receta8)
        recetasRepo.add(repoRecetas.receta9)
        recetasRepo.add(repoRecetas.receta10)
        recetasRepo.add(repoRecetas.receta11)
        recetasRepo.add(repoRecetas.receta12)		
        println(recetasRepo)
		
	}
	
	def filtrarRecetas(String nombre,int caloriasMin,int caloriasMax){
		    var Iterable<Receta> auxiliar = newHashSet
		 
		    auxiliar = this.filtrarPorNombre(recetasRepo,nombre)
			auxiliar=this.filtrarPorCalorias(auxiliar,caloriasMin,caloriasMax)
			recetasFiltradas.addAll(auxiliar.map[r|r.nombre])
			println(recetasFiltradas)
			
		}
	
	def filtrarPorCalorias(Iterable<Receta> recetas, int calMin, int calMax) {
		
		recetas.filter[it.calorias>calMin && it.calorias<calMax]
	}
		
	
	
	def Iterable<Receta> filtrarPorNombre(Collection<Receta> recetas,String nombre) {
		if(nombre!=null)
		return recetas.filter[it.nombre==nombre]
		
	}
	
}