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
		
		if(contieneUsuario(persona))
		usuariosRegistrados.remove(persona)
		
		else throw new NoLoTieneException ("El usuario no está registrado")
	}
	
	def update(Persona persona){
		if(contieneUsuario(buscarPersonaPorNombre(persona))){
		usuariosRegistrados.remove(buscarPersonaPorNombre(persona))
		usuariosRegistrados.add(persona)
		}
		else throw new NoLoTieneException("El usuario no está registrado")
	}
	
	def get(Persona persona){
		
	    buscarPersonaPorNombre(persona)
		
		}
	
	def list(Persona persona){
		
	    filtrarListaPorNombreYCondiciones(persona)
	}
	def agregarAPendiente(Persona persona){
		pendientes.add(persona)
	}
	
	def aceptarUsuario(Persona persona){
		
		if(estaEnPendientes(persona)){
	    pendientes.remove(persona)
		usuariosRegistrados.add(persona)
		}
		else throw new NoLoTieneException("El usuario ingresado no se encuentra en lista de pendientes")
		
	}
	
	def rechazarUsuario(Persona persona, String motivo){
		
		if(estaEnPendientes(persona))
		pendientes.remove(persona)
		println(motivo)
	}
	
	def Persona buscarPersonaPorNombre(Persona persona){
		var usuarionuevo = new Persona()
		usuarionuevo= usuariosRegistrados.findFirst[usuario|usuario.coincideNombre(persona)]
		return usuarionuevo
		
		}
		
	def filtrarListaPorNombreYCondiciones(Persona persona){
		
	 	usuariosRegistrados.filter[usuario|usuario.coincidenCondiciones(persona)].filter[usuario|usuario.coincideNombre(persona)]
		
	 	}
	 
	def contieneUsuario(Persona persona){
		
		usuariosRegistrados.contains(persona)
	} 	
	
	def estaEnPendientes(Persona persona){
		
		pendientes.contains(persona)
	}
	
	def cantidadDeUsuariosRegistrados(){
		
		return usuariosRegistrados.size
	}
	 
}