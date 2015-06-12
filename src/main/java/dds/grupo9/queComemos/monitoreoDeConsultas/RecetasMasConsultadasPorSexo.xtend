package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.excepciones.NoTieneSexoException
import java.util.Hashtable

class RecetasMasConsultadasPorSexo extends RecetasMasConsultadas {
	
	var Hashtable<String, Integer> resultadosHombres = new Hashtable<String, Integer>()
	var Hashtable<String, Integer> resultadosMujeres = new Hashtable<String, Integer>()
	
	override void update(Persona persona, Collection<Receta> recetas){
		for(receta:recetas){
			if(persona.sexo == "M" || persona.sexo == "m"){
				configurarTabla(resultadosHombres, receta)
			} else if(persona.sexo=="F" || persona.sexo=="f"){
				configurarTabla(resultadosMujeres, receta)
			} else { 
			throw new NoTieneSexoException("El sexo ingresado no es válido")
			}
		}
	}
	
	def recetasMasConsultadasPorHombres(int cant){
		mostrarRecetasMasConsultadas(resultadosHombres, cant)
	}
	
	def recetasMasConsultadasPorMujeres(int cant){
		mostrarRecetasMasConsultadas(resultadosMujeres, cant)
	}	
}