package dds.grupo9.queComemos	
import java.util.Collection

/*la compuesta no agrega ingredientes */

class RecetaCompuesta extends Receta {
	
	var Collection <Receta> subrecetas = newHashSet() /*pollo , pure */
	var Collection<Ingrediente> ingredientes= newHashSet()
	
  override def agregarSubreceta(Receta receta){
  	
  	     subrecetas.add(receta)
  	}
  	
	
   override def damePreparacion () {
   	
   	this.explicacion
   }


override def dameIngredientes (){
 	
 	subrecetas.forEach [subreceta | subreceta.dameIngredientes]
 	}
 }
