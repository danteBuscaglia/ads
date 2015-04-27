package dds.grupo9.queComemos

import java.util.Collection

class modEliminarIngredientes implements Modificacion {
	
	var Collection <Ingrediente> ingredientes = newHashSet()
	
	override def ejecutar(Receta receta){
		receta.eliminarTodosLosIngredientes(ingredientes)
	}
	
	def ingredienteAEliminarDeLaReceta(Ingrediente ingrediente,Receta receta){
	if(receta.tieneIngrediente(ingrediente.nombre))
	ingredientes.add(ingrediente)
	}
}