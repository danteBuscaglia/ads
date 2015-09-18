package dds.grupo9.queComemos.controller

import org.eclipse.xtend.lib.annotations.Data
import dds.grupo9.queComemos.Receta
import java.util.Collection
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.applicationModels.SeleccionRecetasAppModel
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas

@Data
class ListadoRecetas {
	
	Collection<Receta> recetas
	
	new(Persona persona, Collection<Receta> recetas) {
		this.recetas = recetas
//		this.recetas = new SeleccionRecetasAppModel(persona, new RecetasMasConsultadas).seleccionDeRecetas
	}
	
}