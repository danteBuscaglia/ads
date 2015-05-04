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
	
	def getGustos(){
		this.gustos
	}
	
	def getIntegrantes(){
		this.integrantes
	}
	
	def agregarPreferencia(Preferencia preferencia){
		gustos.add(preferencia)
	}
	
	def agregarAGrupo(Persona persona){
		integrantes.add(persona)
		persona.agregarGrupo(this)
	}
	
	def incluyeA(Persona persona) {
		integrantes.exists[i|i==persona]
	}
	
	def leGusta(Preferencia preferencia) {
		gustos.contains(preferencia)
	}
	
	def laRecetaEsApropiadaParaTodos(Receta receta) {
		integrantes.forall[!it.recetaNoRecomendada(receta)]
	}
	
}