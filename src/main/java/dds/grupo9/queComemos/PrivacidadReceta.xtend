package dds.grupo9.queComemos

interface PrivacidadReceta {
	
	def boolean puedeVermeOModificarme(Persona persona)
	
	def void cambiosDeReceta(Persona persona, Modificacion modificacion,Receta receta)
	
	
}