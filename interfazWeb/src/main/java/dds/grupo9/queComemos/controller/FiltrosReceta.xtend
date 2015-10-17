package dds.grupo9.queComemos.controller

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Estacion
import queComemos.entrega3.dominio.Dificultad
import dds.grupo9.queComemos.Persona

@Accessors
class FiltrosReceta {
	
	String nombre
	int caloriasMin
	int caloriasMax
	String ingrediente
	Boolean filtrado
	String dificultad
	String temporada
	
}