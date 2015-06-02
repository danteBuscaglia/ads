package dds.grupo9.queComemos.manejoResultadosFiltros

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.filtros.FiltroDecorado
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.monitoreoDeConsultas.Monitor
import dds.grupo9.queComemos.Persona
import java.util.Calendar

class Busqueda {
	
	@Accessors int hour
	@Accessors int x
	@Accessors int cantidadDeVeganos
	@Accessors FiltroDecorado fuenteDeDatos
	@Accessors Proceso proceso
	@Accessors Persona persona
	var Collection<Monitor> monitores = newHashSet()	
	var Collection<Receta> recetasMasConsultadas = newHashSet()
	var Collection<Receta> recetasDeHombre = newHashSet()
	var Collection<Receta> recetasDeMujer = newHashSet()
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
		recetasMasConsultadas.addAll(fuenteDeDatos.resultado)
	}
	
	def recetasMasConsultadas(int cant){
		recetasMasConsultadasOrdenadas(recetasMasConsultadas, cant)
	}
	
	def recetasMasConsultadasOrdenadas(Collection<Receta> recetas, int cant){
		recetas.sortBy[it.cantVecesConsultada].reverse.take(cant).map[it.getNombre()]
	}
	
		
	def void procesarConsultaPorSexo(){
		fuenteDeDatos.resultado.forEach[it.aumentarCantidadDeVecesConsultada()]
		if (persona.sexo == "M" || persona.sexo == "m"){
			recetasDeHombre.addAll(fuenteDeDatos.resultado)
		} else if (persona.sexo == "F" || persona.sexo == "f"){
			recetasDeMujer.addAll(fuenteDeDatos.resultado)
		}
	}
	
	def recetasMasConsultadasPorHombres(int cantidad){
		recetasMasConsultadasOrdenadas(recetasDeHombre, cantidad)
	}
	
	def recetasMasConsultadasPorMujeres(int cantidad){
		recetasMasConsultadasOrdenadas(recetasDeMujer, cantidad)
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
	
