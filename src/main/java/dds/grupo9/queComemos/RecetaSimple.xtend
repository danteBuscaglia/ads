package dds.grupo9.queComemos


class RecetaSimple extends Receta {
	
	override agregarSubreceta(Receta c){
		throw new RuntimeException("Las recetas simples no pueden tener subrecetas")
   	}
   	
   	def RecetaSimple copiaReceta(Persona persona){
		var recetaCopia = new RecetaSimple
		recetaCopia.agregarTodosLosIngredientes(ingredientes)
		super.copiaReceta(recetaCopia, persona)
		return recetaCopia
	}
}


