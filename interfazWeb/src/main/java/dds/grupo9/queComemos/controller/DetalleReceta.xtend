package dds.grupo9.queComemos.controller

import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.Receta
import org.eclipse.xtend.lib.annotations.Data
import queComemos.entrega3.dominio.Dificultad
import java.util.Collection
import dds.grupo9.queComemos.Ingrediente
import dds.grupo9.queComemos.Estacion
import dds.grupo9.queComemos.condicionPreexistente.CondPreexistente
import org.eclipse.xtend.lib.annotations.Accessors

@Data
@Accessors
class DetalleReceta {
	
	Persona persona
	String mensaje
	String nombreReceta
    String explicacion
    int calorias
    Dificultad dificultad
    int tiempoPreparacion
    Collection<Ingrediente> ingredientes= newHashSet() 
    Collection<String> condimentos= newHashSet() 
    Collection<Estacion> temporadasCorrespondientes = newHashSet() 
    Collection<CondPreexistente> condiciones = newHashSet() 
    String nombreDuenio
	
	new(Persona persona, Receta receta) {
		this.nombreReceta = receta.nombre
		this.explicacion = receta.explicacion
		this.calorias = receta.calorias
		this.dificultad = receta.dificultad
		this.tiempoPreparacion = receta.tiempoPreparacion
		this.ingredientes.addAll(receta.ingredientes)
		this.condimentos.addAll(receta.condimentos)
		this.temporadasCorrespondientes.addAll(receta.temporadasCorrespondientes)
		this.condiciones.addAll(receta.condiciones)
		this.nombreDuenio = receta.nombreDuenio	

		this.persona = persona
		this.mensaje = asginarMensajeDuenioReceta(persona, this.nombreDuenio)
	}
	
	def asginarMensajeDuenioReceta(Persona persona, String receta){
		if(nombreDuenio == persona.nombre) return "Usted" 
		else return nombreDuenio
	}
	
}