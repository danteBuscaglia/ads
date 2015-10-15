package dds.grupo9.queComemos.controller

import org.eclipse.xtend.lib.annotations.Data
import dds.grupo9.queComemos.Receta
import java.util.Collection
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas
import org.eclipse.xtend.lib.annotations.Accessors

@Data
@Accessors 
class ListadoRecetas {
	
	Collection<Receta> recetas
	Collection<String> mensajeCorrespondiente
	
	new(Persona persona, Collection<Receta> recetas) {
		mensajeCorrespondiente = newHashSet()
		this.recetas = this.filtrarRecetasAdecuadas(persona, recetas)
	}
	
	def Collection<Receta> filtrarRecetasAdecuadas(Persona persona, Collection<Receta> recetas){
		var Collection<Receta> adecuadas = newHashSet()
		seleccionarRecetasAdecuadas(persona, adecuadas)
		var Collection<Receta> seleccionFinal = newHashSet()
		for(receta:recetas){
			if(esRecetaAdecuada(receta, adecuadas)) seleccionFinal.add(receta)
		}
		println(seleccionFinal.map[it.nombre])
		seleccionFinal
	}
	
	def esRecetaAdecuada(Receta receta, Collection<Receta> adecuadas){
		adecuadas.exists[it.nombre == receta.nombre]
	}
	
	def seleccionarRecetasAdecuadas(Persona persona, Collection<Receta> recetas){
		if(persona.recetasFavoritas.size>0){
			recetas.addAll(persona.recetasFavoritas.take(10))
			mensajeCorrespondiente.add("Estas son tus recetas favoritas")
		}
	else{
			if(persona.ultimasRecetasConsultadas.size>0){
				recetas.addAll(persona.ultimasRecetasConsultadas.take(10))
				mensajeCorrespondiente.add("Estas fueron tus úĺtimas consultas")
			}
			else{
				recetas.addAll((new RecetasMasConsultadas).recetasMasConsultadasRepo(persona.repoRecetas, 3))
				mensajeCorrespondiente.add("Estas son las recetas top del momento")
			}
		}
		
	}	
}