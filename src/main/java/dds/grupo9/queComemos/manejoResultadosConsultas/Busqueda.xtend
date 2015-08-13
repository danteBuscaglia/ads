package dds.grupo9.queComemos.manejoResultadosConsultas

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.monitoreoDeConsultas.Monitor
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.monitoreoDeConsultas.MonitorSinObservers
import dds.grupo9.queComemos.consultas.ConsultaDecorada
import dds.grupo9.queComemos.procesosPeriodicos.ProcesoPeriodico
import dds.grupo9.queComemos.procesosPeriodicos.Batch
import java.util.ArrayList
import dds.grupo9.queComemos.procesosPeriodicos.EnviarMails
import dds.grupo9.queComemos.procesosPeriodicos.LoggerConsultas

class Busqueda {
	
	@Accessors ConsultaDecorada fuenteDeDatos
	@Accessors Proceso proceso
	@Accessors Persona persona
	@Accessors MonitorSinObservers monitorSO
	var Collection<Monitor> monitores = newHashSet()
	@Accessors Batch batch = Batch.getInstance()
	var creadoresProcesosPendientes = new ArrayList<ProcesoPeriodico>
	
	new () {
		creadoresProcesosPendientes.add(new EnviarMails)
		creadoresProcesosPendientes.add(new LoggerConsultas)
   	}

	def Collection<Receta> resultado(){
		proceso.procesar(fuenteDeDatos.resultado)
	}
	
	def Collection<Receta> resultadoSinProcesar(){
		notificar()
		actualizarPendientes()
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
	
	def actualizarPendientes(){
		creadoresProcesosPendientes.forEach[batch.agregarProcesoPeriodico(it.actualizar(persona, fuenteDeDatos.coleccionDeConsultas, fuenteDeDatos.resultado))]
	}
	
	/*def actualizarPendientes(){
		
		batch.actualizarPendientes(persona,fuenteDeDatos.coleccionDeConsultas,fuenteDeDatos.resultado)
	}*/
	
}
	
