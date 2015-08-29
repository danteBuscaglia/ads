package dds.grupo9.queComemos.applicationModels

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas
import dds.grupo9.queComemos.Receta

@Observable
@Accessors

class SeleccionRecetasAppModel {
	
	Persona persona
	RecetasMasConsultadas recetasMasConsultadas
	Receta recetaSeleccionada
	
	new(Persona persona){
		this.persona = persona
	}
}