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
	
	Persona persona = new Persona
	RecetasMasConsultadas monitorDeConsultas = new RecetasMasConsultadas()
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
			seleccionDeRecetas.addAll(persona.recetasFavoritas)
			mensajeCorrespondiente = "Estas son tus recetas favoritas"
		}
	else{
			if(persona.ultimasRecetasConsultadas.size>0){
				seleccionDeRecetas.addAll(persona.ultimasRecetasConsultadas)
				mensajeCorrespondiente = "Estas fueron tus úĺtimas consultas"
			}
			else{
				seleccionDeRecetas.addAll(monitorDeConsultas.recetasMasConsultadasRepo(persona.repoRecetas, 3))
				mensajeCorrespondiente = "Estas son las recetas top del momento"
			}
		}
		
	}
	
	/*def definirColores(){
		for(receta:seleccionDeRecetas){
			if (receta.getNombreDueño == "D10S"){
				background = Color.BLUE
			} else if (receta.getNombreDueño == persona.nombre){
				background = Color.ORANGE
			}
		}
	}*/
}