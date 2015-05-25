package dds.grupo9.queComemos

import java.util.Collection
import dds.grupo9.queComemos.excepciones.NoLoTieneException

class RepoUsuarios {
	
	var Collection<Persona> usuariosRegistrados = newHashSet()
	var Collection<Persona> pendientes = newHashSet
	
	def add(Persona persona){
		      
		       usuariosRegistrados.add(persona)
		}
	
	def remove(Persona persona){
		
		if(usuariosRegistrados.contains(persona))
		usuariosRegistrados.remove(persona)
		
		else throw new NoLoTieneException ("El usuario no está registrado")
	}
	
	def update(PerfilDeUsuario perfil){
		
		
	}
	
	def get(PerfilDeUsuario perfil){
		
	    buscarPersonaPorNombre(perfil)
		
		}
	
	def list(PerfilDeUsuario perfil){
		
	    filtrarListaPorNombreYCondiciones(perfil)
	}
	def agregarAPendiente(Persona persona){
		usuariosRegistrados.add(persona)
	}
	
	def Persona buscarPersonaPorNombre(PerfilDeUsuario perfil){
		var usuarionuevo = new Persona()
		usuarionuevo= usuariosRegistrados.findFirst[usuario|usuario.coincideNombre(perfil)]
		return usuarionuevo
		
		}
		
	def filtrarListaPorNombreYCondiciones(PerfilDeUsuario perfil){
		
	 	usuariosRegistrados.filter[usuario|usuario.coincidenCondiciones(perfil)].filter[usuario|usuario.coincideNombre(perfil)]
		
	 	}
	 
}