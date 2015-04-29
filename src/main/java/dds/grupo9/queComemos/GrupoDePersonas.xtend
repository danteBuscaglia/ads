package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection

class GrupoDePersonas {
	@Accessors String nombre
	var Collection <Preferencia> gustos = newHashSet()
	var Collection <Persona> integrantes = newHashSet()
	
	new(String nombreGrupo){
		nombre=nombreGrupo
		
	}
	
	def agregarAGrupo(Persona persona){
	
	integrantes.add(persona)
	persona.agregarGrupo(this)
	}
	
	def incluyeDuenioDeReceta(Receta receta) {
		integrantes.exists[i|i==receta.duenio]
	}
	
}