package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.consultas.ConsultaDecorada
import java.util.Collection
import dds.grupo9.queComemos.Receta

interface ProcesoPeriodico{
	
	def void ejecutar()
	
	def void actualizar(Persona persona, ConsultaDecorada consulta, Collection<Receta> recetas)
	
	
	
	
}