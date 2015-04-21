package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection

 class Receta {
	
	@Accessors String nombre /*Nombre del plato */
    @Accessors String explicacion /*Pasos a seguir en la receta */
    @Accessors int calorias /*Calorías de la receta (A modificar) */
    @Accessors String dificultad /*Dificultad de la receta */
    var Persona duenio /* Usuario que sube la receta */
    var Collection<Ingrediente> ingredientes= newHashSet() /*Ingredientes de la receta */
    val Collection <Estacion> temporadasCorrespondientes = newHashSet() /*Temporadas a las que corresponde la receta */
    var Collection <CondPreexistente> condiciones = newHashSet() /* Condiciones preexistentes */
   
   	def agregarIngrediente(Ingrediente ingrediente)/*Agrega un ingrediente a la lista de la receta*/{
   		ingredientes.add(ingrediente)
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
  
 	def tieneIngrediente(String nombreIngrediente){ /* Evalúa si dado el nombre de un ingrediente, la receta lo contiene */
  		!(filtrarPorNombre(nombreIngrediente)).isEmpty
  	}
  
  	def tieneMuchoIngredienteAzucar(){ /* Calcula si la receta tiene más de 100 gramos de azúcar */
    	(ingredientes.filter[ingred | ingred.tieneMuchoAzucar()]).size > 0
  	}
  	 
  	def filtrarPorNombre(String nombreIngrediente){  
  		ingredientes.filter[ingrediente|ingrediente.soyYo(nombreIngrediente)]
  	}
  
  	def recetaInadecuadaPara (){ /*Muestra las condiciones para la que una receta es inadecuada */
  		condiciones.filter[condicion|condicion.recetaNoRecomendada(this)]
  	}
  	
  	def crearDuenio(Persona persona){
  		duenio = persona
  	}
  	
  	def puedeVermeOModificarme(Persona persona){
  		duenio == persona
  	}
	
	def damePreparacion() {
	
	this.explicacion
	}
	
   def agregarSubreceta(Receta c){
   	
   	 }
   	 
   	def dameIngredientes(){
   		
   		return ingredientes
   	} 
	
}