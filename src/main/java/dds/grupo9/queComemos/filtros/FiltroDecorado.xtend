package dds.grupo9.queComemos.filtros

import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.observer.Observador

interface FiltroDecorado {
	
	def Collection<Receta> resultado()
	
	def void suscribirse(Observador suscriptor)
	
	def void cancelarSuscripcion(Observador suscriptor)
	
	def void actualizar()
	
		
	
	
}