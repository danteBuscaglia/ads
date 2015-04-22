package dds.grupo9.queComemos

class modAgregarIngrediente implements Modificacion {
	
	var Ingrediente ingrediente
	
	override def ejecutar(Receta receta){
		receta.agregarIngrediente(ingrediente)
	}
}