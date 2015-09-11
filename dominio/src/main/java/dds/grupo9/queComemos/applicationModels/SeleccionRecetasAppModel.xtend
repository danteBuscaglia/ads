package dds.grupo9.queComemos.applicationModels

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas
import dds.grupo9.queComemos.Receta
import java.util.Collection
import java.awt.Color

@Observable
@Accessors

class SeleccionRecetasAppModel {
	
	Persona persona
	RecetasMasConsultadas monitorDeConsultas
	Receta recetaSeleccionada
 	String mensajeCorrespondiente = ""
 	Collection<Receta> seleccionDeRecetas = newHashSet()
 	
	
	new(Persona persona, RecetasMasConsultadas rmc){
		this.persona = persona
		this.monitorDeConsultas = rmc
		this.seleccionarRecetasAdecuadas
	}
	
	def seleccionarRecetasAdecuadas(){
		if(persona.recetasFavoritas.size>0){
			seleccionDeRecetas.addAll(persona.recetasFavoritas.take(10))
			mensajeCorrespondiente = "Estas son tus recetas favoritas"
		}
	else{
			if(persona.ultimasRecetasConsultadas.size>0){
				seleccionDeRecetas.addAll(persona.ultimasRecetasConsultadas.take(10))
				mensajeCorrespondiente = "Estas fueron tus úĺtimas consultas"
			}
			else{
				seleccionDeRecetas.addAll(monitorDeConsultas.recetasMasConsultadasRepo(persona.repoRecetas, 3))
				mensajeCorrespondiente = "Estas son las recetas top del momento"
			}
		}
		
	}
	
}