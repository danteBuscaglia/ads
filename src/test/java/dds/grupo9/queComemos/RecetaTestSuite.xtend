package dds.grupo9.queComemos

import org.junit.Test
import org.junit.Assert


class RecetaTestSuite {
	
	
	@Test
	
	def void unaRecetaEsValida(){
		
		val receta = new RecetaSimple()
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias=3000
		
		Assert.assertTrue(receta.recetaValida)
	}
	
	@Test
	def void unaRecetaTieneCarneYAzucarYSal(){
	
		val receta = new RecetaSimple()

		receta.agregarIngrediente(new Ingrediente("azucar", 150))
		receta.agregarIngrediente(new Ingrediente("sal", 15))
		receta.agregarIngrediente(new Ingrediente("carne", 300))
		
		receta.calorias=500
				
		Assert.assertTrue(receta.tieneIngrediente("carne"))	
		Assert.assertTrue(receta.tieneIngrediente("sal"))	
		Assert.assertTrue(receta.tieneIngrediente("azucar"))	
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
		
	}
	
	@Test
	def void unaPersonaNoPuedeModificarLaRecetaPrivadaDeOtra(){
		val duenioDeReceta = new Persona()
		val otraPersona = new Persona()
		val receta = new RecetaSimple()
		receta.duenio=duenioDeReceta
		
		Assert.assertFalse(receta.puedeVermeOModificarme(otraPersona))
		
		}
		
		@Test
	def void unaPersonaPuedeModificarUnaRecetaPublica(){
		val persona= new Persona()
		val receta = new RecetaSimple()
		
		Assert.assertTrue(receta.puedeVermeOModificarme(persona))
		
		
		}
		
		@Test
	def void unaPersonaAgregaIngredientesAUnaReceta(){
		
		val persona = new Persona()
		val receta = new RecetaSimple()
		val modificacion = new modAgregarIngredientes()
		receta.agregarIngrediente(new Ingrediente ("papa",100))
		receta.calorias=400
		
		modificacion.ingredienteAAgregar(new Ingrediente("sal",10))
		
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertTrue(receta.ingredientes.length==2)
	}
	
	/* @Test
	def void siUnaPersonaModificaUnaRecetaPublicaLaOtraPersonaNoVeLosCambios(){
		
		val persona = new Persona()
		val persona2 = new Persona()
		val receta= new RecetaSimple()
		val modificacion = new modAgregarIngredientes()
		
		receta.agregarIngrediente(new Ingrediente("fideos",200))
		receta.agregarIngrediente(new Ingrediente("agua",100))
		receta.agregarIngrediente(new Ingrediente("manteca",25))
		receta.agregarIngrediente(new Ingrediente("leche",50))
		
		modificacion.ingredienteAAgregar(new Ingrediente("casancrem",40))
		
		persona.modificarReceta(receta,modificacion)
		
		
		Assert.assert
		
		*/
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