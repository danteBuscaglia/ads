package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta

class RecetasMasConsultadasPorSexo extends RecetasMasConsultadas {
	
	var Collection<Receta> recetasDeHombre = newHashSet()
	var Collection<Receta> recetasDeMujer = newHashSet()
	
	override void update(Persona persona, Collection<Receta> recetas){
		recetas.forEach[it.aumentarCantidadDeVecesConsultada()]
		if (persona.sexo == "M" || persona.sexo == "m"){
			recetasDeHombre.addAll(recetas)
		} else if (persona.sexo == "F" || persona.sexo == "f"){
			recetasDeMujer.addAll(recetas)
		}
	}
	
	def recetasMasConsultadasPorHombres(int cantidad){
		mostrarRecetasMasConsultadasOrdenadas(recetasDeHombre, cantidad)
	}
	
	def recetasMasConsultadasPorMujeres(int cantidad){
		mostrarRecetasMasConsultadasOrdenadas(recetasDeMujer, cantidad)
	}
}