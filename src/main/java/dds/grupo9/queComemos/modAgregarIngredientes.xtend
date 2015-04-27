package dds.grupo9.queComemos

import java.util.Collection

class modAgregarIngredientes implements Modificacion {
	
	var Collection <Ingrediente> ingredientes = newHashSet()
	
	override def ejecutar(Receta receta){
	 receta.agregarTodosLosIngredientes(ingredientes)
	}
	
    def ingredienteAAgregar(Ingrediente ingrediente){
    ingredientes.add(ingrediente)
	}
}