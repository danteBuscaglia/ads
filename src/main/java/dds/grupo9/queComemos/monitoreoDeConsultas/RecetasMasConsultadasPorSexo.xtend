package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.excepciones.NoTieneSexoException

class RecetasMasConsultadasPorSexo extends RecetasMasConsultadas {
	
	var Collection<Receta> recetasDeHombre = newHashSet()
	var Collection<Receta> recetasDeMujer = newHashSet()
	
	override void update(Persona persona, Collection<Receta> recetas){
		recetas.forEach[it.aumentarCantidadDeVecesConsultada()]
		if (persona.sexo == "M" || persona.sexo == "m"){
			recetasDeHombre.addAll(recetas)
		} else if (persona.sexo == "F" || persona.sexo == "f"){
			recetasDeMujer.addAll(recetas)
		} else { 
			throw new NoTieneSexoException("El sexo ingresado no es válido")
		}
	}
	
	def recetasMasConsultadasPorHombres(int cantidad){
		mostrarRecetasMasConsultadasOrdenadas(recetasDeHombre, cantidad)
	}
	
	def recetasMasConsultadasPorMujeres(int cantidad){
		mostrarRecetasMasConsultadasOrdenadas(recetasDeMujer, cantidad)
	}
}