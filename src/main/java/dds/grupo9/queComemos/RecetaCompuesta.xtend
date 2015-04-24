package dds.grupo9.queComemos	
import java.util.Collection

class RecetaCompuesta extends Receta {
	
	var Collection <Receta> subrecetas = newHashSet()
   	 
  	override agregarSubreceta(Receta receta){ /*Agrega una subreceta a la receta compuesta e incorpora sus ingredientes */
 
  	     subrecetas.add(receta)
  	     this.agregarTodosLosIngrediente(receta.ingredientes)
  	}
	
	override Receta copiaReceta(Persona persona){
		var recetaCopia = new RecetaCompuesta
		recetaCopia.nombre = nombre
		recetaCopia.explicacion = explicacion
		recetaCopia.calorias = calorias
		recetaCopia.dificultad = dificultad
		recetaCopia.subrecetas = subrecetas
		recetaCopia.ingredientes = ingredientes
		recetaCopia.duenio = persona
		recetaCopia.temporadasCorrespondientes = temporadasCorrespondientes
		recetaCopia.condiciones = condiciones
		
		return recetaCopia
	}
 }
