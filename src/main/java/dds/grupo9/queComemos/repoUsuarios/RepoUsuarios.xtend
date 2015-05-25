package dds.grupo9.queComemos.repoUsuarios

import java.util.Collection
import dds.grupo9.queComemos.excepciones.NoLoTieneException

class RepoUsuarios {
	
	var Collection<dds.grupo9.queComemos.Persona> usuariosRegistrados = newHashSet()
	var Collection<dds.grupo9.queComemos.Persona> pendientes = newHashSet
	
	def add(dds.grupo9.queComemos.Persona persona){
		usuariosRegistrados.add(persona)
	}
	
	def remove(dds.grupo9.queComemos.Persona persona){
		if(contieneUsuario(persona))
		usuariosRegistrados.remove(persona)
		else throw new NoLoTieneException ("El usuario no está registrado")
	}
	
	def update(dds.grupo9.queComemos.Persona persona){
		if(contieneUsuario(buscarPersonaPorNombre(persona))){
			usuariosRegistrados.remove(buscarPersonaPorNombre(persona))
			usuariosRegistrados.add(persona)
		}
		else throw new NoLoTieneException("El usuario no está registrado")
	}
	
	def get(dds.grupo9.queComemos.Persona persona){
	    buscarPersonaPorNombre(persona)
	}
	
	def list(dds.grupo9.queComemos.Persona persona){
	    filtrarListaPorNombreYCondiciones(persona)
	}
	
	def agregarAPendiente(dds.grupo9.queComemos.Persona persona){
		pendientes.add(persona)
	}
	
	def aceptarUsuario(dds.grupo9.queComemos.Persona persona){
		if(estaEnPendientes(persona)){
	    pendientes.remove(persona)
		usuariosRegistrados.add(persona)
		}
		else throw new NoLoTieneException("El usuario ingresado no se encuentra en lista de pendientes")
	}
	
	def rechazarUsuario(dds.grupo9.queComemos.Persona persona, String motivo){
		if(estaEnPendientes(persona)){
			pendientes.remove(persona)
			println(motivo)
		}
	}
	
	def dds.grupo9.queComemos.Persona buscarPersonaPorNombre(dds.grupo9.queComemos.Persona persona){
		var usuarionuevo = new dds.grupo9.queComemos.Persona()
		usuarionuevo = usuariosRegistrados.findFirst[usuario|usuario.coincideNombre(persona)]
		return usuarionuevo
	}
		
	def filtrarListaPorNombreYCondiciones(dds.grupo9.queComemos.Persona persona){
	 	usuariosRegistrados.filter[usuario|usuario.coincidenCondiciones(persona)].filter[usuario|usuario.coincideNombre(persona)]
	}
	 
	def contieneUsuario(dds.grupo9.queComemos.Persona persona){
		usuariosRegistrados.contains(persona)
	} 	
	
	def estaEnPendientes(dds.grupo9.queComemos.Persona persona){
		
		pendientes.contains(persona)
	}
	
	def cantidadDeUsuariosRegistrados(){
		
		return usuariosRegistrados.size
	}
	 
}