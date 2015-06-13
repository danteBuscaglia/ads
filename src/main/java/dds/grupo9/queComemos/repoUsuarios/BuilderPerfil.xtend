package dds.grupo9.queComemos.repoUsuarios

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.condicionPreexistente.CondPreexistente
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.GrupoDePersonas
import dds.grupo9.queComemos.repoRecetas.RepoRecetas


class BuilderPerfil {
	
	@Accessors Persona perfilUsuario
	
	def build(){
	
	   perfilUsuario 
		
	}
	
	def asignarNombre(String unNombre) {
		perfilUsuario.nombre = unNombre
		this
	}
	
	def asignarPeso(float unPeso) {
		perfilUsuario.peso = unPeso
		this
	}
	
	def asignarAltura(float unaAltura) {
		perfilUsuario.altura = unaAltura
		this
	}
	
	def asignarSexo(String sexo) {
		perfilUsuario.sexo = sexo
		this
	}
	
	def asignarFechaNacimiento(long fechaNacimiento) {
		perfilUsuario.fechaNacimiento = fechaNacimiento
		this
	}
	
	def asignarUnGusto(String unGusto) {
		perfilUsuario.agregarPreferencia(unGusto)
		this
	}

	
	def asignarUnDisguto(String unGusto) {
		perfilUsuario.agregarDisgusto(unGusto)
		this
	}
	
	def asignarUnaCondicionPreexistente(CondPreexistente unaCondicion) {
		perfilUsuario.agregarCondPreexistente(unaCondicion)
		this
	}
	
	def asignarRutina(String rutina) {
		perfilUsuario.rutina = rutina
		this
	}
	
	def asignarUnaRecetaPropia(Receta unaReceta) {
		perfilUsuario.agregarReceta(unaReceta)
		this
	}
	
	def asignarUnGrupo(GrupoDePersonas unGrupo) {
		unGrupo.agregarAGrupo(perfilUsuario)
		this
	}
	
	def asginarRepoRecetas(RepoRecetas repositorio) {
		perfilUsuario.repoRecetas = repositorio
		this
	}
	 	
	
}
