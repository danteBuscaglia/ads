package dds.grupo9.queComemos

class modEliminarIngredientes implements Modificacion {
	
	var Ingrediente ingrediente
	
	def setIngrediente(Ingrediente i){
		ingrediente = i	
	}
	
	override def ejecutar(Receta receta){
		if(receta.tieneIngrediente(ingrediente.nombre)){
			receta.eliminarIngredientesPorNombre(ingrediente.nombre)
		}
		else throw new RuntimeException("La receta no contiene ese ingrediente")
	}
}