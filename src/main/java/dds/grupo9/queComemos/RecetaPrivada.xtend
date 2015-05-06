package dds.grupo9.queComemos

class RecetaPrivada implements PrivacidadReceta{
	
	static Persona creador /* Creador de la receta */
	
	new(Persona persona){
		creador = persona
	}
	
	override puedeVermeOModificarme(Persona persona){
	persona.comparteGrupoCon(creador) || persona == creador
	}
	
	override cambiosDeReceta(Persona persona, Modificacion modificacion, Receta receta){
		modificacion.ejecutar(receta)
	}
}