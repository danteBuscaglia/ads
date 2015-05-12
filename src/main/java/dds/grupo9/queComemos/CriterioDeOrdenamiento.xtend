package dds.grupo9.queComemos

import java.util.Collection

interface CriterioDeOrdenamiento {
	
	def Collection<Receta> ordenar(Collection<Receta> recetas)
	
}