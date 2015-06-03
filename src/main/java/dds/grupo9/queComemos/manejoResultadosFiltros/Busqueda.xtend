package dds.grupo9.queComemos.manejoResultadosFiltros

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.filtros.FiltroDecorado
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.monitoreoDeConsultas.Monitor
import dds.grupo9.queComemos.Persona
import java.util.Calendar
import dds.grupo9.queComemos.excepciones.NoTieneSexoException

class Busqueda {
	
	@Accessors int hour
	@Accessors int x
	@Accessors int cantidadDeVeganos
	@Accessors FiltroDecorado fuenteDeDatos
	@Accessors Proceso proceso
	@Accessors Persona persona
	var Collection<Monitor> monitores = newHashSet()	
	var Collection<Receta> recetasConsultadas = newHashSet()
	var consultasPorHora = newIntArrayOfSize(24)
	var Calendar calendario = Calendar.getInstance()
	

	def Collection<Receta> resultado(){
		proceso.procesar(fuenteDeDatos.resultado)
	}
	
	def Collection<Receta> resultadoSinProcesar(){
		notificar()
		procesarRecetasMasConsultadas()
		procesarConsultaPorSexo()
		procesarConsultaVeganosRecetasDificiles()
		procesarConsultaPorHora()
		fuenteDeDatos.resultado()
	}

	def void notificar(){
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
			
	
	def void procesarRecetasMasConsultadas(){
		fuenteDeDatos.resultado.forEach[it.aumentarCantidadDeVecesConsultada()]
		recetasConsultadas.addAll(fuenteDeDatos.resultado)
	}
	
	def recetasMasConsultadas(int cant){
		recetasMasConsultadasOrdenadas(recetasConsultadas, cant)
	}
	
	def recetasMasConsultadasOrdenadas(Collection<Receta> recetas, int cant){
		var Collection<String> recetasFinal = newHashSet()
		recetasFinal.addAll(recetas.sortBy[it.cantVecesConsultada].reverse.take(cant).map[it.getNombre()])
		recetasFinal
	}
	
		
	def void procesarConsultaPorSexo(){
		fuenteDeDatos.resultado.forEach[it.aumentarCantidadDeVecesConsultada()]
		if (persona.sexo == "M" || persona.sexo == "m" || persona.sexo=="F" || persona.sexo=="f"){
			recetasConsultadas.addAll(fuenteDeDatos.resultado)
		} else {
			throw new NoTieneSexoException("La persona no indica el sexo")
		}
	}
	
	def recetasMasConsultadasPorHombres(int cantidad){
		var Collection<String> recetasFinal = newHashSet()
		recetasFinal.addAll(recetasConsultadas.sortBy[it.cantVecesConsultadaPorHombres].reverse.take(cantidad).map[it.getNombre()])
		recetasFinal
	}
	
	def recetasMasConsultadasPorMujeres(int cantidad){
		var Collection<String> recetasFinal = newHashSet()
		recetasFinal.addAll(recetasConsultadas.sortBy[it.cantVecesConsultadaPorMujeres].reverse.take(cantidad).map[it.getNombre()])
		recetasFinal
	}
	
	
	def void procesarConsultaVeganosRecetasDificiles(){
		if(persona.esVegano()){
			var Iterable<Receta> recetasDificiles = newHashSet()
			recetasDificiles = fuenteDeDatos.resultado.filter[it.esDificil()]
			if(recetasDificiles.size > 0){
				cantidadDeVeganos++
			}
		}
	}
	
	def cantidadDeVeganosQueConsultaronRecetasDificiles(){
		cantidadDeVeganos
	}
	
	
	def void procesarConsultaPorHora(){
		hour = calendario.get(Calendar.HOUR_OF_DAY)
		x = consultasPorHora.get(hour)
		consultasPorHora.set(hour, x++)
	}
	
	def consultasPorHora(int hora){
		if(hora>23 || hora<0){
			throw new RuntimeException("no es una hora válida")
		} else {
			consultasPorHora.get(hora)
		}
	}
	
}
	
