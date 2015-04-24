package dds.grupo9.queComemos

import org.junit.Test
import org.junit.Assert
import java.util.Collection

class RecetaTestSuite {
	
	
	@Test
	
	def void unaRecetaEsValida(){
		
		val receta = new RecetaSimple()
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias=3000
		
		Assert.assertTrue(receta.recetaValida)
	}
	
	@Test
	
	def void unaPersonaPuedeVerOModificarUnaRecetaDada(){
		
		var persona = new Persona()
		var persona2 = new Persona()
		persona.nombre = "jose"
		persona2.nombre = "juan"
		var receta = new RecetaSimple()
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias = 3000
		persona.agregarReceta(receta)
		
		Assert.assertTrue(receta.puedeVermeOModificarme(persona))
		Assert.assertFalse(receta.puedeVermeOModificarme(persona2))
	}
	
	@Test
	
	def void unaRecetaCompuestaReutilizaDosRecetasSimples(){
		
		var recetaSimple1 = new RecetaSimple()
		var recetaSimple2 = new RecetaSimple()
		var recetaCompuesta = new RecetaCompuesta()

		recetaSimple1.agregarIngrediente(new Ingrediente("pollo", 1))
		recetaSimple1.agregarIngrediente(new Ingrediente("oregano", 10))
		recetaSimple2.agregarIngrediente(new Ingrediente("papa", 5))
		recetaSimple2.agregarIngrediente(new Ingrediente("manteca", 1))
		
		recetaCompuesta.agregarSubreceta(recetaSimple1)
		recetaCompuesta.agregarSubreceta(recetaSimple2)
		
		Assert.assertTrue(recetaCompuesta.tieneIngrediente("pollo"))		
		Assert.assertTrue(recetaCompuesta.tieneIngrediente("oregano"))
		Assert.assertTrue(recetaCompuesta.tieneIngrediente("papa"))
		Assert.assertTrue(recetaCompuesta.tieneIngrediente("manteca"))

	}	
	
	@Test
	
	def void unaRecetaCompuestaReutilizaUnaRecetaSimpleYOtraCompuesta(){
		
		var recetaSimple1 = new RecetaSimple()
		var recetaSimple2 = new RecetaSimple()
		var recetaSimple3 = new RecetaSimple()
		var recetaCompuesta = new RecetaCompuesta()
		var recetaCompuestaNivel2 = new RecetaCompuesta()

		recetaSimple1.agregarIngrediente(new Ingrediente("pollo", 1))
		recetaSimple1.agregarIngrediente(new Ingrediente("oregano", 10))
		recetaSimple2.agregarIngrediente(new Ingrediente("papa", 5))
		recetaSimple2.agregarIngrediente(new Ingrediente("manteca", 1))
		recetaSimple3.agregarIngrediente(new Ingrediente("arroz", 5))
		recetaSimple3.agregarIngrediente(new Ingrediente("salsaDeSoja", 1))
		
		recetaCompuesta.agregarSubreceta(recetaSimple1)
		recetaCompuesta.agregarSubreceta(recetaSimple2)
		
		recetaCompuestaNivel2.agregarSubreceta(recetaCompuesta)
		recetaCompuestaNivel2.agregarSubreceta(recetaSimple3)
		
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente("pollo"))		
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente("oregano"))
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente("papa"))
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente("manteca"))
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente("arroz"))
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente("salsaDeSoja"))

	}
	
		
	
}