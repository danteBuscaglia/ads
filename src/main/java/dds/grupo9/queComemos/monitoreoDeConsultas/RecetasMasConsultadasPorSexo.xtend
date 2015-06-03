package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.excepciones.NoTieneSexoException
import dds.grupo9.queComemos.ordenamientoResultados.CriterioDeOrdenamiento
import org.eclipse.xtend.lib.annotations.Accessors

class RecetasMasConsultadasPorSexo extends RecetasMasConsultadas {
	
	var Collection<Receta> recetasConsultadas = newHashSet()
	@Accessors CriterioDeOrdenamiento criterio
	
	override void update(Persona persona, Collection<Receta> recetas){
		recetas.forEach[it.aumentarCantidadDeVecesConsultada(persona.sexo)]
		if (persona.sexo == "M" || persona.sexo == "m" || persona.sexo=="F" || persona.sexo=="f"){
			recetasConsultadas.addAll(recetas)
		} else { 
			throw new NoTieneSexoException("El sexo ingresado no es válido")
		}
	}
	
	def Collection<String> recetasMasConsultadasPorSexo(int cant){
		mostrarRecetasMasConsultadasOrdenadas(cant)
	}
	
	def Collection<String> mostrarRecetasMasConsultadasOrdenadas(int cantidad){
		var Collection<String> recetasFinales = newHashSet()
		recetasFinales.addAll(criterio.ordenar(recetasConsultadas).take(cantidad).map[it.getNombre()])
		recetasFinales
	}
	
}