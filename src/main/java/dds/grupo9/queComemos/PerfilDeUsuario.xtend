package dds.grupo9.queComemos

import dds.grupo9.queComemos.condicionPreexistente.CondPreexistente
import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors

class PerfilDeUsuario {
	
	@Accessors String nombrePerfil
	var Collection <CondPreexistente> condicionesPerfil
	     
	new(String nombrePersona){
		
		nombrePerfil= nombrePersona
		
		}
		
   new(String nombrePersona,Collection<CondPreexistente> condicionesABuscar){
		
		nombrePerfil= nombrePersona
		condicionesPerfil= condicionesABuscar
		
		}
		
	def getCondiciones(){
		
		return condicionesPerfil
	}
}