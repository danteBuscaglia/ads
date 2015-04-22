package dds.grupo9.queComemos

class modEliminarIngrediente implements Modificacion {
	
	var Ingrediente ingrediente
	
	override def ejecutar(Receta receta){
		receta.eliminarIngrediente(ingrediente)
	}
	
}