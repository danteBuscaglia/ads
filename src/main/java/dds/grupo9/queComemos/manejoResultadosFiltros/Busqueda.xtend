package dds.grupo9.queComemos.manejoResultadosFiltros

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.filtros.FiltroDecorado
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.monitoreoDeConsultas.Monitor
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.monitoreoDeConsultas.MonitorSinObservers

class Busqueda {
	
	@Accessors FiltroDecorado fuenteDeDatos
	@Accessors Proceso proceso
	@Accessors Persona persona
	@Accessors MonitorSinObservers monitorSO
	var Collection<Monitor> monitores = newHashSet()	
	

	def Collection<Receta> resultado(){
		proceso.procesar(fuenteDeDatos.resultado)
	}
	
	def Collection<Receta> resultadoSinProcesar(){
		notificar()
		if(!(monitorSO==null)){
			monitorSO.procesarRecetasMasConsultadas(fuenteDeDatos.resultado)
			monitorSO.procesarConsultaPorSexo(fuenteDeDatos.resultado, persona)
			monitorSO.procesarConsultaVeganosRecetasDificiles(fuenteDeDatos.resultado, persona)
			monitorSO.procesarConsultaPorHora()
		}
		return fuenteDeDatos.resultado()
	}

	def void notificar(){

			monitores.forEach[it.update(persona, fuenteDeDatos.resultado())]
		
	}

	def agregarMonitor(Monitor monitor){
		monitores.add(monitor)
	}
	
	def eliminarMonitor(Monitor monitor){
		monitores.remove(monitor)
	}
			
}
	
