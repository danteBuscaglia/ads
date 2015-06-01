package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta

class RecetasMasConsultadasPorSexo implements Monitor {
	
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
	
	def recetasMasConsultadasPorSexo(int cantidad){
		var Collection<Receta> recetasMasConsultadasPorSexo = newHashSet()
		recetasMasConsultadasPorSexo.addAll(recetasDeHombre.sortBy[it.cantVecesConsultada].take(cantidad))
		recetasMasConsultadasPorSexo.addAll(recetasDeMujer.sortBy[it.cantVecesConsultada].take(cantidad))
		return recetasMasConsultadasPorSexo
	}
// Debería hacer un println para que me muestre separadas las recetas consultadas por hombres y las consultadas por mujeres	
}