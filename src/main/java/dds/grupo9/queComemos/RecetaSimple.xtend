package dds.grupo9.queComemos


class RecetaSimple extends Receta {
	
	override agregarSubreceta(Receta c){
		throw new RuntimeException("Las recetas simples no pueden tener subrecetas")
   	}
   	
   	override Receta copiaReceta(Persona persona){
		var recetaCopia = new RecetaSimple
		recetaCopia.nombre = nombre
		recetaCopia.explicacion = explicacion
		recetaCopia.calorias = calorias
		recetaCopia.dificultad = dificultad
		recetaCopia.ingredientes = ingredientes
		recetaCopia.duenio = persona
		recetaCopia.temporadasCorrespondientes = temporadasCorrespondientes
		recetaCopia.condiciones = condiciones
		
		return recetaCopia
	}
}


