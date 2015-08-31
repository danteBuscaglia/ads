package dds.grupo9.queComemos

import dds.grupo9.queComemos.modificacionRecetas.Modificacion

interface PrivacidadReceta {
	
	def boolean puedeVermeOModificarme(Persona persona)
	
	def void cambiosDeReceta(Persona persona, Modificacion modificacion,Receta receta)
	
 	def Persona getDueño()
 	
 	def String getNombreDueño()
	
	
}