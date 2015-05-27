package dds.grupo9.queComemos.repoUsuarios

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.Preferencia
import dds.grupo9.queComemos.condicionPreexistente.CondPreexistente
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.GrupoDePersonas
import dds.grupo9.queComemos.RepoRecetasPropio

abstract class BuilderPersona {
	
	@Accessors Persona perfilUsuario
	
	def generarNuevoPerfil(){
		perfilUsuario = new Persona()
	}
	
	def asignarNombre(String unNombre) {
		perfilUsuario.nombre = unNombre
	}
	
	def asignarPeso(float unPeso) {
		perfilUsuario.peso = unPeso
	}
	
	def asignarAltura(float unaAltura) {
		perfilUsuario.altura = unaAltura
	}
	
	def asignarSexo(String sexo) {
		perfilUsuario.sexo = sexo
	}
	
	def asignarFechaNacimiento(long fechaNacimiento) {
		perfilUsuario.fechaNacimiento = fechaNacimiento
	}
	
	def asignarUnGusto(Preferencia unGusto) {
		perfilUsuario.agregarPreferencia(unGusto)
	}
	
	def asignarUnDisguto(Preferencia unGusto) {
		perfilUsuario.agregarDisgusto(unGusto)
	}
	
	def asignarUnaCondicionPrexistente(CondPreexistente unaCondicion) {
		perfilUsuario.agregarCondPreexistente(unaCondicion)
	}
	
	def asignarRutina(String rutina) {
		perfilUsuario.rutina = rutina
	}
	
	def asignarUnaRecetaPropia(Receta unaReceta) {
		perfilUsuario.agregarReceta(unaReceta)
	}
	
	def asignarUnGrupo(GrupoDePersonas unGrupo) {
		unGrupo.agregarAGrupo(perfilUsuario)
	}
	
	def asginarRepoRecetas(RepoRecetasPropio repositorio) {
		perfilUsuario.repoRecetas = repositorio
	}
	 	
	
}