package dds.grupo9.queComemos.manejoResultadosFiltros

import java.util.Collection
import dds.grupo9.queComemos.Receta

interface Proceso {

	def Collection<Receta> procesar(Collection<Receta> recetas)
	
}