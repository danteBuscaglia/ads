package dds.grupo9.queComemos	
import java.util.Collection

class RecetaCompuesta extends Receta {
	
	var Collection <Receta> subrecetas = newHashSet()
	
	new(RepoRecetas repositorio) {
		super(repositorio)
	}
	
	new(Persona persona){
		super(persona)
	}
	
   	 
   	def getSubrecetas(){
   		this.subrecetas
   	} 
   	
   	override getIngredientes(){
		this.ingredientesDinamicos
   	}
	
	def ingredientesDinamicos() {
		var Collection <Ingrediente> ingredientesDinamicos = newHashSet()
   		for(subreceta:subrecetas)
   		ingredientesDinamicos.addAll(subreceta.ingredientes)
   		return ingredientesDinamicos
	}
	
	override filtrarIngredientesPorNombre(Preferencia nombreIngrediente){  
  		this.ingredientesDinamicos.filter[ingrediente|ingrediente.soyYo(nombreIngrediente)]
  	}
   	 
  	override agregarSubreceta(Receta receta){ /*Agrega una subreceta a la receta compuesta */
  	     subrecetas.add(receta)
  	}
  	
  	def agregarTodasLasSubrecetas(RecetaCompuesta recetaCompuesta){
  		subrecetas.addAll(recetaCompuesta.subrecetas)
  	}
	
	override RecetaCompuesta copiaReceta(Persona persona){
		var recetaCopia = new RecetaCompuesta(persona)
		recetaCopia.agregarTodasLasSubrecetas(this)
		super.copiarAtributosComunes(recetaCopia, persona)
		return recetaCopia
	}
 }
