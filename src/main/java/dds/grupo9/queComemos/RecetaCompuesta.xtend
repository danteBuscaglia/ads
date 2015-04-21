package dds.grupo9.queComemos	
import java.util.Collection

class RecetaCompuesta extends Receta {
	
	var Collection <Receta> subrecetas = newHashSet()
	var Collection<Ingrediente> misIngredientes= newHashSet() /*Ingredientes de la receta */
	    
  override agregarSubreceta(Receta receta){ /*Agrega una subreceta a la receta compuesta e incorpora sus ingredientes */
  	
  	     subrecetas.add(receta)
  	     misIngredientes.addAll(receta.dameIngredientes)
  	}
  	
	
   override damePreparacion () {
   	
   		this.explicacion
   }
 
   	override dameIngredientes(){ /*Las recetas compuestas tendran una lista propia de ingredientes que se irá componiendo en la medida que se le agreguen subrecetas */
   		
   		misIngredientes
   	}
	
 }
