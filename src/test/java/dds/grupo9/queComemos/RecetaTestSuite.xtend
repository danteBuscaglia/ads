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
	
	@Test
	
	def void cualquierPersonaPuedeVerOModificarUnaRecetaPublica(){
		
		var persona = new Persona()
		var persona2 = new Persona()
		var recetaPublica = new RecetaPublica()
		
		Assert.assertTrue(recetaPublica.puedeVermeOModificarme(persona))
		Assert.assertTrue(recetaPublica.puedeVermeOModificarme(persona2))
	}
	
	@Test
	
	def void unaPersonaPuedeVerOModificarUnaRecetaDada(){
		
		var persona = new Persona()
		var persona2 = new Persona()
		persona.nombre = "jose"
		persona2.nombre = "juan"
		var receta = new Receta()
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias = 3000
		persona.agregarReceta(receta)
		
		Assert.assertTrue(receta.puedeVermeOModificarme(persona))
		Assert.assertFalse(receta.puedeVermeOModificarme(persona2))
	}
		
	
	
	
	
}