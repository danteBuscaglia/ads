package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection

abstract class Receta {
	
	@Accessors String nombre /*Nombre del plato */
    @Accessors String explicacion /*Pasos a seguir en la receta */
    @Accessors int calorias /*Calorías de la receta (A modificar) */
    @Accessors String dificultad /*Dificultad de la receta */
    var Persona duenio /* Usuario que sube la receta */
    var Collection<Ingrediente> ingredientes= newHashSet() /*Ingredientes de la receta */
    var Collection<Estacion> temporadasCorrespondientes = newHashSet() /*Temporadas a las que corresponde la receta */
    var Collection<CondPreexistente> condiciones = newHashSet() /* Condiciones preexistentes */
    
    
    def getIngredientes(){
		this.ingredientes
	}
	
	def getTemporadasCorrespondientes(){
		this.temporadasCorrespondientes
	}
	
	def getCondiciones(){
		this.condiciones
	}
	
	def getDuenio(){
		this.duenio
	}
	
	def setIngredientes(Collection<Ingrediente> i){
		this.ingredientes = i
	}
	
	def setTemporadasCorrespondientes(Collection<Estacion> tc){
		this.temporadasCorrespondientes = tc
	}
	
	def setCondiciones(Collection<CondPreexistente> c){
		this.condiciones = c
	}
	
	def setDuenio(Persona d){
		this.duenio = d
	}
       
   	def agregarIngrediente(Ingrediente ingrediente){/*Agrega un ingrediente a la lista de la receta*/
   		ingredientes.add(ingrediente)
   	} 
   	
   	def agregarTodosLosIngredientes(Collection<Ingrediente> ingredientesParaAgregar ){/*Agrega un ingrediente a la lista de la receta*/
   		ingredientes.addAll(ingredientesParaAgregar)
   	} 
   	
   	def eliminarIngrediente(Ingrediente ingrediente){
   		ingredientes.remove(ingrediente)
   	}
   	
   	def eliminarTodosLosIngredientes(Collection<Ingrediente> ingredientesParaRemover){
   		ingredientes.removeAll(ingredientesParaRemover)
   	}
   		
	def eliminarIngredientesPorNombre(String nombreIngrediente){
		ingredientes.removeAll(this.filtrarIngredientesPorNombre(nombreIngrediente))
	}
   
	def recetaValida(){ /*Evalúa si una receta cumple con las condiciones para considerarse como tal */
   		(this.tieneIngredientes && this.contieneCaloriasRazonables) 
   	}
   
   	def tieneIngredientes(){/* Evalúa si la receta tiene al menos 1 ingrediente */
   		ingredientes.size>0
   	}
  
  	def contieneCaloriasRazonables(){ /*Define límites de calorías para una receta */
  		calorias>10 && calorias <5000
  	}
  
  	def tieneMasDeUnaCantidadDe(int cantidadMax, Ingrediente ingredienteBuscado){ /* Calcula si la receta tiene más de X gramos de un determinado Ingrediente */
    	(ingredientes.filter[ingrediente | ingrediente.tieneMasDeLoPermitidoDe(cantidadMax, ingredienteBuscado)]).size > 0
  	}
  	
  	def tieneIngrediente(String nombreIngrediente){ /* Evalúa si dado el nombre de un ingrediente, la receta lo contiene */
  		!filtrarIngredientesPorNombre(nombreIngrediente).isEmpty
  	}
  	 
  	def filtrarIngredientesPorNombre(String nombreIngrediente){  
  		ingredientes.filter[ingrediente|ingrediente.soyYo(nombreIngrediente)]
  	}
  
  	def recetaInadecuadaPara (){ /*Muestra las condiciones para la que una receta es inadecuada */
  		condiciones.filter[condicion|condicion.recetaNoRecomendada(this)]
  		
  	}
  	
  	def cantidadDeIngredientes(){
  		ingredientes.length
  	}
  	
  	def crearDuenio(Persona persona){
  		duenio = persona
  	}
  	
  	def boolean puedeVermeOModificarme(Persona persona){
		if(this.esPrivada()){
			duenio == persona || persona.leCompartenLaReceta(this)
		} 
		else {
			true
		}
	}
	
	def esPrivada(){
		this.duenio != null
	}
		
	def void sufrirCambios(Persona persona, Modificacion modificacion){
		if(!esPrivada){
			var recetaCopia = this.copiaReceta(persona)
			persona.agregarReceta(recetaCopia)
  		    modificacion.ejecutar(recetaCopia)
  		    
  		}
  		else
  		{
  			modificacion.ejecutar(this)
  		}
	}
	
	def Receta copiaReceta(Persona persona){
		
	}
	
   	def agregarSubreceta(Receta c){
   	
   	}	
}