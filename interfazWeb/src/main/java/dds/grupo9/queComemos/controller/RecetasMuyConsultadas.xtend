package dds.grupo9.queComemos.controller

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas
import java.util.Collection
import dds.grupo9.queComemos.Receta
import static dds.grupo9.queComemos.controller.ConfiguredDependencies.*

@Accessors
class RecetasMuyConsultadas {
	
	RecetasMasConsultadas monitorRecetas
	Collection<Receta> recetasADevolver = newArrayList
	Collection<Integer> consultas = newArrayList
	 
	
	
	
	new(RecetasMasConsultadas monitor){
		monitorRecetas=monitor
		recetasADevolver=monitorRecetas.recetasMasConsultadasRepo(repoRecetas,10)
	    consultas.addAll(monitorRecetas.obtenerConsultas)
	}
	
	
}