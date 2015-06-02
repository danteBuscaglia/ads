package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Receta
import java.util.Collection
import dds.grupo9.queComemos.Persona
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Calendar

class ConsultasPorHora implements Monitor {
	
	@Accessors int hour
	@Accessors int x
	var consultasPorHora = newArrayOfSize(24)
	var Calendar calendario = Calendar.getInstance()
	
	override void update(Persona persona, Collection<Receta> recetas){
		hour = calendario.get(Calendar.HOUR) //Si dice PM le agrega 12
		consultasPorHora.set(hour, x++)
	}
	
	def consultasPorHora(int hora){
		if(hora>12 || hora<0){
			throw new RuntimeException("no es una hora válida")
		} else {
			consultasPorHora.get(hora)
		}
	}
	
	def obtenerHora(){
		hour = calendario.get(Calendar.HOUR)
	}
	
}