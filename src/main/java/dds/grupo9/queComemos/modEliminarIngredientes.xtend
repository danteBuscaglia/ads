package dds.grupo9.queComemos

import java.util.Collection

class modEliminarIngredientes implements Modificacion {
	
	var Collection <Ingrediente> ingredientes = newHashSet()
	
	override def ejecutar(Receta receta){
		receta.eliminarTodosLosIngredientes(ingredientes)
	}
	
	def ingredienteAEliminar(Ingrediente ingrediente){
	ingredientes.add(ingrediente)
	}
}