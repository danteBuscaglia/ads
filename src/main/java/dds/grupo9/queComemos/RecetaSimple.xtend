package dds.grupo9.queComemos


class RecetaSimple extends Receta {
	
	override agregarSubreceta(Receta c){
		throw new NoEsValidoException("Las recetas simples no pueden tener subrecetas")
   	}
   	
   	override RecetaSimple copiaReceta(Persona persona){
		var recetaCopia = new RecetaSimple
		recetaCopia.agregarTodosLosIngredientes(ingredientes)
		super.copiarAtributosComunes(recetaCopia, persona)
		return recetaCopia
	}
}


