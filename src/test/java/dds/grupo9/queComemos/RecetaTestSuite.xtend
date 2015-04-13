package dds.grupo9.queComemos

import org.junit.Test
import org.junit.Assert

class RecetaTestSuite {
	
	
	@Test
	
	def void unaRecetaEsValida(){
		val receta = new Receta()
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias=3000
		
		Assert.assertTrue(receta.recetaValida)
		
		}
	
	
		
	
	
	
	
}