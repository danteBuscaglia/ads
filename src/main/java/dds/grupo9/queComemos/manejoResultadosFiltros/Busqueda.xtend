package dds.grupo9.queComemos.manejoResultadosFiltros

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.filtros.FiltroDecorado
import java.util.Collection
import dds.grupo9.queComemos.Receta

class Busqueda {
	
	@Accessors FiltroDecorado fuenteDeDatos
	@Accessors Proceso proceso	
	
	def Collection<Receta> resultado(){
		proceso.procesar(fuenteDeDatos.resultado)
	}
	
}