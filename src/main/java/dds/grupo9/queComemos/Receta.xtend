package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection
import dds.grupo9.queComemos.condicionPreexistente.CondPreexistente
import dds.grupo9.queComemos.modificacionRecetas.Modificacion
import queComemos.entrega3.dominio.Dificultad
import dds.grupo9.queComemos.repoRecetas.RepoRecetas

abstract class Receta{
	
	@Accessors String nombre /*Nombre del plato */
    @Accessors String explicacion /*Pasos a seguir en la receta */
    @Accessors int calorias /*Calorías de la receta (A modificar) */
    @Accessors Dificultad dificultad /*Dificultad de la receta */
    @Accessors int tiempoPreparacion
    var Collection<Ingrediente> ingredientes= newHashSet() /*Ingredientes de la receta */
    var Collection<Estacion> temporadasCorrespondientes = newHashSet() /*Temporadas a las que corresponde la receta */
    var Collection<CondPreexistente> condiciones = newHashSet() /* Condiciones preexistentes */
    var PrivacidadReceta privacidad /* Condición de privacidad de la receta (publica o privada) */
    @Accessors int cantVecesConsultada = 0
    
    new (RepoRecetas repositorio){
    	
    	privacidad = new RecetaPublica ()
//    	repositorio.agregarRecetaPublica(this)	
    }
    new(Persona persona){
    	privacidad = new RecetaPrivada(persona)
    }
    
    
    
    def cambioAPrivada(Persona persona){
    	
    	privacidad= new RecetaPrivada(persona)
    }
    
    def getIngredientes(){
		this.ingredientes
	}
	
	def getTemporadasCorrespondientes(){
		this.temporadasCorrespondientes
	}
	
	def getCondiciones(){
		this.condiciones
	}
	
	def setIngredientes(Collection<Ingrediente> i){
		ingredientes.addAll(i)
	}
	
	def setTemporadasCorrespondientes(Collection<Estacion> tc){
		temporadasCorrespondientes.addAll(tc)
	}
	
	def setCondiciones(Collection<CondPreexistente> c){
		condiciones.addAll(c)
	}
       
   	def agregarIngrediente(Ingrediente ingrediente){/*Agrega un ingrediente a la lista de la receta*/
   		ingredientes.add(ingrediente)
   	} 
   	
   	def agregarTodosLosIngredientes(Collection<Ingrediente> ingredientesParaAgregar ){/*Agrega ingredientes a la lista de la receta*/
   		ingredientes.addAll(ingredientesParaAgregar)
   	} 
   	
   	def eliminarIngrediente(Ingrediente ingrediente){
   		ingredientes.remove(ingrediente)
   	}
   	
   	def eliminarTodosLosIngredientes(Collection<Ingrediente> ingredientesParaRemover){
   		ingredientes.removeAll(ingredientesParaRemover)
   	}
   		
	def eliminarIngredientesPorNombre(Preferencia nombreIngrediente){
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
  	
  	def tieneIngrediente(Preferencia nombreIngrediente){ /* Evalúa si dado el nombre de un ingrediente, la receta lo contiene */
  		!filtrarIngredientesPorNombre(nombreIngrediente).isEmpty
  	}
  	 
  	def filtrarIngredientesPorNombre(Preferencia nombreIngrediente){  
  		ingredientes.filter[ingrediente|ingrediente.soyYo(nombreIngrediente)]
  	}
  
  	def recetaInadecuadaPara (){ /*Muestra las condiciones para la que una receta es inadecuada */
		condiciones.filter[condicion|condicion.recetaNoRecomendada(this)]
  		
  	} // Habria que hacerlo dinámico
  	
  	
  	def boolean puedeVerOModificarReceta(Persona persona){
		privacidad.puedeVermeOModificarme(persona)
	}
	
		
	def void sufrirCambios(Persona persona, Modificacion modificacion){
		privacidad.cambiosDeReceta(persona,modificacion,this)
  		}
	
	
	def agregarCondiciones(Collection<CondPreexistente> condicionesParaAgregar){
		condiciones.addAll(condicionesParaAgregar)
	} // Habria que hacerlo dinámico
	
	def agregarTemporadas(Collection<Estacion> temporadasParaAgregar){
		temporadasCorrespondientes.addAll(temporadasParaAgregar)
	} // Habria que hacerlo dinámico
	
	def cantidadIngredientes(){
		ingredientes.size
	}
		
	def Receta copiaReceta(Persona persona) 
	
	def void agregarSubreceta(Receta c)	
		
	def Receta copiarAtributosComunes(Receta recetaCopia, Persona persona){
			recetaCopia.nombre = nombre
		recetaCopia.explicacion = explicacion
		recetaCopia.calorias = calorias
		recetaCopia.dificultad = dificultad
		recetaCopia.agregarTemporadas(temporadasCorrespondientes)
		recetaCopia.agregarCondiciones(condiciones)
		return recetaCopia
			
		}
	
	/*Entrega 2 Punto 1. Invocar con: receta.puedeSerSugeridaA(unaPresona/unGrupo) es polimórfica */
	def puedeSerSugeridaA(Persona unaPersona){
		unaPersona.noContieneIngredientesQueLeDisgusten(this)	&& !unaPersona.recetaNoRecomendada(this)
	}
	
	def puedeSerSugeridaA(GrupoDePersonas unGrupo){
		unGrupo.contieneAlgunIngredienteQuePrefiereElGrupo(this) && unGrupo.laRecetaEsApropiadaParaTodos(this)	
	}
	
	def tieneIngredientesCaros(){
		ingredientes.exists[it.esCaro()]
	}
	
	/*Entrega 3 */
	def Persona getDueño(){
		privacidad.getDueño()
	}
	
	def aumentarCantidadDeVecesConsultada(){
		cantVecesConsultada++
	}
	
	def esDificil(){
		this.dificultad == Dificultad.DIFICIL
	}
	
	def getNombre(){
		this.nombre
	}	
}