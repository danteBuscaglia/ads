package dds.grupo9.queComemos.manejoResultadosFiltros

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.filtros.FiltroDecorado
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.monitoreoDeConsultas.Monitor
import dds.grupo9.queComemos.Persona
import java.util.Calendar

class Busqueda {
	
	@Accessors int lahora
	@Accessors int y
	@Accessors int cantidadDeVeganos
	@Accessors FiltroDecorado fuenteDeDatos
	@Accessors Proceso proceso
	@Accessors Persona persona
	var Collection<Monitor> monitores = newHashSet()	
	var Collection<Receta> recetasMasConsultadas
	var Collection<Receta> recetasHombre = newHashSet()
	var Collection<Receta> recetasMujer = newHashSet()
	var consultasPorHoraa = newArrayOfSize(24)
	var Calendar calendarioo = Calendar.getInstance()
	

	def Collection<Receta> resultado(){
		notificar()
		proceso.procesar(fuenteDeDatos.resultado)
	}
	
	def Collection<Receta> resultadoSinProcesar(){
		notificar()
		procesarRecetasMasConsultadas(persona , fuenteDeDatos.resultado)
		procesarConsultaPorSexo(persona , fuenteDeDatos.resultado)
		procesarConsultaVeganosRecetasDificiles(persona , fuenteDeDatos.resultado)
		procesarConsultaPorHora(persona , fuenteDeDatos.resultado)
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
	
		
	
	def void procesarRecetasMasConsultadas(Persona persona, Collection<Receta> recetas){
		recetas.forEach[it.aumentarCantidadDeVecesConsultada()]
		recetasMasConsultadas.addAll(recetas)
	}
	
	def lasRecetasMasConsultadas(int cant){
		lasRecetasMasConsultadasOrdenadas(recetasMasConsultadas, cant)
	}
	
	def lasRecetasMasConsultadasOrdenadas(Collection<Receta> recetas, int cant){
		recetas.sortBy[it.cantVecesConsultada].reverse.take(cant).map[it.getNombre()]
	}
	
	

	
	def void procesarConsultaPorSexo(Persona persona, Collection<Receta> recetas){
		recetas.forEach[it.aumentarCantidadDeVecesConsultada()]
		if (persona.sexo == "M" || persona.sexo == "m"){
			recetasHombre.addAll(recetas)
		} else if (persona.sexo == "F" || persona.sexo == "f"){
			recetasMujer.addAll(recetas)
		}
	}
	
	def lasRecetasMasConsultadasPorHombres(int cantidad){
		lasRecetasMasConsultadasOrdenadas(recetasHombre, cantidad)
	}
	
	def lasRecetasMasConsultadasPorMujeres(int cantidad){
		lasRecetasMasConsultadasOrdenadas(recetasMujer, cantidad)
	}
	
	
	
	def void procesarConsultaVeganosRecetasDificiles(Persona persona, Collection<Receta> recetas){
		if(persona.esVegano()){
			var Iterable<Receta> recetasDificiles = newHashSet()
			recetasDificiles = recetas.filter[it.esDificil()]
			if(recetasDificiles.size > 0){
				cantidadDeVeganos++
			}
		}
	}
	
	def laCantidadDeVeganosQueConsultaronRecetasDificiles(){
		cantidadDeVeganos
	}
	
	
	
	
	def void procesarConsultaPorHora(Persona persona, Collection<Receta> recetas){
		lahora = calendarioo.get(Calendar.HOUR)
		consultasPorHoraa.set(lahora, y++)
	}
	
	def lasConsultasPorHora(int hora){
		if(hora>12 || hora<0){
			throw new RuntimeException("no es una hora válida")
		} else {
			consultasPorHoraa.get(hora)
		}
	}
	
	def dameHora(){
		lahora = calendarioo.get(Calendar.HOUR)
	}
}
	
