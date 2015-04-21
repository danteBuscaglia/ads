package dds.grupo9.queComemos

import org.junit.Test
import org.junit.Assert
import java.util.Collection

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
	
	@Test
	
	def void unaRecetaCompuestaReutilizaRecetasSimples(){
		
		var recetaSimple1 = new RecetaSimple()
		var recetaSimple2 = new RecetaSimple()
		var recetaCompuesta = new RecetaCompuesta()
    	var ingrediente1 = new Ingrediente("pollo", 1)
    	var ingrediente2 = new Ingrediente("oregano", 10)
    	var ingrediente3 = new Ingrediente("papa", 5)
    	var ingrediente4 = new Ingrediente("manteca", 1)

		recetaSimple1.agregarIngrediente(ingrediente1)
		recetaSimple1.agregarIngrediente(ingrediente2)
		recetaSimple2.agregarIngrediente(ingrediente3)
		recetaSimple2.agregarIngrediente(ingrediente4)
		recetaCompuesta.agregarSubreceta(recetaSimple1)
		recetaCompuesta.agregarSubreceta(recetaSimple2)
		
		Assert.assertTrue(recetaCompuesta.dameIngredientes.contains(ingrediente1))		
		Assert.assertTrue(recetaCompuesta.dameIngredientes.contains(ingrediente2))
		Assert.assertTrue(recetaCompuesta.dameIngredientes.contains(ingrediente3))
		Assert.assertTrue(recetaCompuesta.dameIngredientes.contains(ingrediente4))

	}
		
	
	
	
	
}