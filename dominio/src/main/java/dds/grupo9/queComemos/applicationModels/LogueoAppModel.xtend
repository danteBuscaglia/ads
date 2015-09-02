package dds.grupo9.queComemos.applicationModels

import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.repoUsuarios.RepoUsuarioEjemplo
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas
import org.uqbar.commons.model.UserException

@Observable
@Accessors

class LogueoAppModel {
	
 	Persona persona
 	String contrasegna 
 	RepoUsuarioEjemplo repoUsuarios
 	
 	new(){
 		repoUsuarios = new RepoUsuarioEjemplo
 		persona = new Persona
 		contrasegna = "sinContrasegna"
 	}
	
	def Persona personaBuscada(){
		var Persona personaEncontrada
		personaEncontrada  = repoUsuarios.get(persona)
		
		if (personaEncontrada.contrasegna != contrasegna)
		{
			throw new UserException("Contraseña incorrecta")
		}
		
		personaEncontrada
		
	}
	
	def RecetasMasConsultadas monitor(){
		repoUsuarios.monitor
	}
}