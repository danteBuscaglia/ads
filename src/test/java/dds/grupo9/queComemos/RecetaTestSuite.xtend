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
	
	def void unaPersonaQueAgregaIngredienteAUnaRecetaPropiaLograModificarlaSinGenerarUnaCopia(){
		
		val persona = new Persona()
		val receta = new RecetaSimple()
		receta.duenio = persona
		var modificacion = new modAgregarIngredientes()
		receta.agregarIngrediente(new Ingrediente ("papa",100))
		modificacion.ingrediente = new Ingrediente("sal", 10)
		receta.calorias=400
		
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertEquals(receta.cantidadDeIngredientes(), 2)
	}
	
	@Test
	
	def void unaPersonaQueEliminaIngredienteAUnaRecetaPropiaLograModificarlaSinGenerarUnaCopia(){
		
		val persona = new Persona()
		val receta = new RecetaSimple()
		receta.duenio = persona
		val modificacion = new modEliminarIngredientes()
		val papa = new Ingrediente("papa",100)
		val sal = new Ingrediente("sal",10)
		receta.agregarIngrediente(papa)
		receta.agregarIngrediente(sal)
		receta.calorias=400
		
		modificacion.ingrediente = new Ingrediente("sal")
		/* Nótese que no es necesario conocer exactamente el objeto ingrediente a eliminar, sino solo el nombre */
		
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertEquals(receta.cantidadDeIngredientes(), 1)
	}
	
	@Test
	
	def void unaPersonaQueModificaUnaRecetaPublicaIncorporaComoPropiaUnaReceta(){
		
		val persona = new Persona()
		val receta = new RecetaSimple()
		val modificacion = new modEliminarIngredientes()
		val papa = new Ingrediente("papa",100)
		val sal = new Ingrediente("sal",10)
		receta.agregarIngrediente(papa)
		receta.agregarIngrediente(sal)
		receta.calorias=400
		
		modificacion.ingrediente = new Ingrediente("sal")
		
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertTrue(persona.tieneXRecetas(1))
	}	

	@Test
	
	def void unaPersonaQueEliminaIngredienteDeUnaRecetaPublicaIncorporaComoPropiaUnaRecetaConMenosIngredientes(){
		
		val persona = new Persona()
		val receta = new RecetaSimple()
		receta.nombre = "papasALaCrema"
		val modificacion = new modEliminarIngredientes()
		val papa = new Ingrediente("papa",100)
		val crema = new Ingrediente("crema",25)
		val sal = new Ingrediente("sal",10)
		receta.agregarIngrediente(papa)
		receta.agregarIngrediente(crema)
		receta.agregarIngrediente(sal)
		receta.calorias=600
		
		modificacion.ingrediente = new Ingrediente("sal")
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertTrue(persona.tieneXRecetas(1))
		Assert.assertEquals(2, persona.cantidadIngredientesReceta("papasALaCrema"))
	}
	
		@Test
	
	def void unaPersonaQueAgregaIngredienteDeUnaRecetaPublicaIncorporaComoPropiaUnaRecetaConMasIngredientes(){
		
		val persona = new Persona()
		val receta = new RecetaSimple()
		receta.nombre = "papasALaCrema"
		val modificacion = new modAgregarIngredientes()
		val papa = new Ingrediente("papa",100)
		val crema = new Ingrediente("crema",25)
		receta.agregarIngrediente(papa)
		receta.agregarIngrediente(crema)
		receta.calorias=600
		
		modificacion.ingrediente = new Ingrediente("sal",10)
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertTrue(persona.tieneXRecetas(1))
		Assert.assertEquals(3, persona.cantidadIngredientesReceta("papasALaCrema"))
	}
		
	/*@Test
	def void siUnaPersonaModificaUnaRecetaPublicaLaOtraPersonaNoVeLosCambios(){
		
		val persona = new Persona()
		val persona2 = new Persona()
		val receta = new RecetaSimple()
		val modificacion = new modAgregarIngredientes()
		
		receta.agregarIngrediente(new Ingrediente("fideos",200))
		receta.agregarIngrediente(new Ingrediente("agua",100))
		receta.agregarIngrediente(new Ingrediente("manteca",25))
		receta.agregarIngrediente(new Ingrediente("leche",50))
		
		modificacion.ingrediente = new Ingrediente("casancrem",40)
		
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertFalse(receta.tieneIngrediente("casancrem"))
	}*/	
	
	
	@Test (expected = RuntimeException)
	
	def void unaRecetaSimpleNoPuedeTenerSubrecetas(){
		var recetaSimple1 = new RecetaSimple()
		var recetaSimple2 = new RecetaSimple()
		
		recetaSimple1.agregarIngrediente(new Ingrediente("pollo", 1))
		recetaSimple2.agregarIngrediente(new Ingrediente("papa", 8))
		
		recetaSimple1.agregarSubreceta(recetaSimple2)
		
		Assert.assertTrue(recetaSimple1.tieneIngrediente("papa"))
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
	@Test
	
	def unaPersonaPuedeVerLaRecetaDeUnCompañeroDeGrupo(){
		val persona = new Persona()
		val persona2= new Persona()
		val grupo = new GrupoDePersonas("Los Pibes")
		val receta = new RecetaSimple()
		
		grupo.agregarAGrupo(persona)
		grupo.agregarAGrupo(persona2)
		
		receta.agregarIngrediente(new Ingrediente("sal",10))
		receta.agregarIngrediente(new Ingrediente("carne",100))
		receta.calorias=150
		persona.agregarReceta(receta)
		
		Assert.assertTrue(receta.puedeVermeOModificarme(persona2))
		
	}	
		
	@Test
	
	def laCopiaDeUnaRecetaSimpleCopiaTodosSusAtributosExceptoElDuenioQueSeVeModificado(){
		val persona = new Persona()
		persona.nombre = "juan"
		val receta = new RecetaSimple()
		var recetaCopia = new RecetaSimple()
		val papa = new Ingrediente("papa",100)
		val sal = new Ingrediente("sal",10)
		receta.agregarIngrediente(papa)
		receta.agregarIngrediente(sal)
		recetaCopia = receta.copiaReceta(persona)
		
		Assert.assertTrue(recetaCopia.tieneIngrediente("sal"))
		Assert.assertTrue(recetaCopia.tieneIngrediente("papa"))
		Assert.assertEquals(persona, recetaCopia.duenio)
	}		
		
		
		
		
		
	}
	
	
		
	
