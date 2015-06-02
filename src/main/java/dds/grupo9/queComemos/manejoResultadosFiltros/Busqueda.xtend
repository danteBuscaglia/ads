package dds.grupo9.queComemos.manejoResultadosFiltros

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.filtros.FiltroDecorado
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.monitoreoDeConsultas.Monitor
import dds.grupo9.queComemos.Persona

class Busqueda {
	
	@Accessors FiltroDecorado fuenteDeDatos
	@Accessors Proceso proceso
	@Accessors Persona persona
	var Collection<Monitor> monitores = newHashSet()	

	def Collection<Receta> resultado(){
		notificar()
		proceso.procesar(fuenteDeDatos.resultado)
	}
	
	def Collection<Receta> resultadoSinProcesar(){
		notificar()
		fuenteDeDatos.resultado()
	}

	def notificar(){
		if(monitores.size>0){
			monitores.forEach[it.update(persona, fuenteDeDatos.resultado())]
		}
	}

	def agregarMonitor(Monitor monitor){
		monitores.add(monitor)
	}
	
	def eliminarMonitor(Monitor monitor){
		monitores.remove(monitor)
	}
	
}