package dds.grupo9.queComemos.procesosPeriodicos

import java.util.ArrayList
import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.consultas.Consulta
import dds.grupo9.queComemos.Receta
import org.eclipse.xtend.lib.annotations.Accessors

class Batch {
	
	var creadoresProcesosPendientes = new ArrayList<ProcesoPeriodico>
	var procesosPeriodicos = new ArrayList<ProcesoPeriodico>	
	private static Batch instance = null;
	
	protected new () {
		creadoresProcesosPendientes.add(new EnviarMails)
		creadoresProcesosPendientes.add(new LoggerConsultas)
   	}
   	
   	def public static Batch getInstance() {
      if(instance == null) {
         instance = new Batch();
      }
      return instance;
   	}
   	
   	def getProcesosPeriodicos(){
   		procesosPeriodicos
   	}
   	
   	def agregarProcesoPeriodico(ProcesoPeriodico procesoPer){
		procesosPeriodicos.add(procesoPer)
	}
	
	def ejecutarprocesoPeriodico(){ 
		procesosPeriodicos.forEach[it.ejecutar()]
	}		
	
	def actualizarPendientes(Persona persona, Collection<Consulta> coleccionDeConsultas, Collection<Receta> resultado){
		creadoresProcesosPendientes.forEach[this.agregarProcesoPeriodico(it.actualizar(persona, coleccionDeConsultas, resultado))]
	}
	
}