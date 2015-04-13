package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection

class Receta {
	
	@Accessors String nombre /*Nombre del plato */
    @Accessors String explicacion /*Pasos a seguir en la receta */
    @Accessors int calorias /*Calorías de la receta (A modificar) */
    @Accessors String dificultad /*Dificultad de la receta */
    val Collection<Ingrediente> ingredientes= newHashSet() /*Ingredientes de la receta */
    val Collection <Condimento> condimentos= newHashSet() /*Condimentos de la receta */
    val Collection <Estacion> temporadasCorrespondientes = newHashSet() /*Temporadas a las que corresponde la receta */
   
   def agregarIngrediente(Ingrediente ingrediente)/*Agrega un ingrediente a la lista de la receta*/{
   	ingredientes.add(ingrediente)
   } 
   def agregarCondimento(Condimento condimento){ /*Agrega un condimento a la lista de la receta */
   	condimentos.add(condimento)
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
   
    }