package dds.grupo9.queComemos

class modAgregarIngredientes implements Modificacion {
	
	var Ingrediente ingrediente

	def setIngrediente(Ingrediente i){
		ingrediente = i	
	}	
	
	override def ejecutar(Receta receta){
		receta.agregarIngrediente(ingrediente)
	}
	
}