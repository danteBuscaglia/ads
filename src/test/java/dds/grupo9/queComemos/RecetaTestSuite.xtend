package dds.grupo9.queComemos

import org.junit.Test
import org.junit.Assert
import dds.grupo9.queComemos.condicionPreexistente.Vegano
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.condicionPreexistente.Celiaco
import dds.grupo9.queComemos.excepciones.NoEsValidoException
import dds.grupo9.queComemos.modificacionRecetas.modAgregarIngredientes
import dds.grupo9.queComemos.modificacionRecetas.modEliminarIngredientes
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio

class RecetaTestSuite {
	
	
	@Test
	
	def void unaRecetaEsValida(){
		
		val receta = new RecetaSimple(new RepoRecetasPropio())
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias=3000
		
		Assert.assertTrue(receta.recetaValida)
	}
	
	@Test
	def void unaRecetaTieneCarneYAzucarYSal(){
	
		val receta = new RecetaSimple(new RepoRecetasPropio())

		receta.agregarIngrediente(new Ingrediente(Preferencia.AZUCAR, 150))
		receta.agregarIngrediente(new Ingrediente(Preferencia.SAL, 15))
		receta.agregarIngrediente(new Ingrediente(Preferencia.CARNE, 300))
		
		receta.calorias=500
				
		Assert.assertTrue(receta.tieneIngrediente(Preferencia.CARNE))	
		Assert.assertTrue(receta.tieneIngrediente(Preferencia.SAL))	
		Assert.assertTrue(receta.tieneIngrediente(Preferencia.AZUCAR))	
	}
	
	
	
	@Test
	
	def void unaPersonaPuedeVerOModificarUnaRecetaDada(){
		
		var persona = new Persona()
		var persona2 = new Persona()
		persona.nombre = "jose"
		persona2.nombre = "juan"
		var receta = new RecetaSimple(persona)
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias = 3000
		persona.agregarReceta(receta)
		
		Assert.assertTrue(receta.puedeVerOModificarReceta(persona))
		
	}
	
	@Test
	
	def void unaPersonaNoPuedeModificarLaRecetaPrivadaDeOtra(){
	
		val duenioDeReceta = new Persona()
		val otraPersona = new Persona()
		val receta = new RecetaSimple(duenioDeReceta)
		
		
		Assert.assertFalse(receta.puedeVerOModificarReceta(otraPersona))
		
	}
		
	@Test
	
	def void unaPersonaPuedeModificarUnaRecetaPublica(){
	
		val persona= new Persona()
		val receta = new RecetaSimple(new RepoRecetasPropio())
		
		Assert.assertTrue(receta.puedeVerOModificarReceta(persona))
	}
		
	@Test
	
	def void unaPersonaQueAgregaIngredienteAUnaRecetaPropiaLograModificarlaSinGenerarUnaCopia(){
		
		val persona = new Persona()
		val receta = new RecetaSimple(persona)
		var modificacion = new modAgregarIngredientes()
		receta.agregarIngrediente(new Ingrediente (Preferencia.PAPA,100))
		modificacion.ingrediente = new Ingrediente(Preferencia.SAL, 10)
		receta.calorias=400
		
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertEquals(receta.cantidadIngredientes(), 2)
	}
	
	@Test
	
	def void unaPersonaQueEliminaIngredienteAUnaRecetaPropiaLograModificarlaSinGenerarUnaCopia(){
		
		val persona = new Persona()
		val receta = new RecetaSimple(persona)
		val modificacion = new modEliminarIngredientes()
		val papa = new Ingrediente(Preferencia.PAPA,100)
		val sal = new Ingrediente(Preferencia.SAL,10)
		receta.agregarIngrediente(papa)
		receta.agregarIngrediente(sal)
		receta.calorias=400
		
		modificacion.ingrediente = new Ingrediente(Preferencia.SAL)
		/* Nótese que no es necesario conocer exactamente el objeto ingrediente a eliminar, sino solo el nombre */
		
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertEquals(receta.cantidadIngredientes(), 1)
	}
	
	@Test
	
	def void unaPersonaQueModificaUnaRecetaPublicaIncorporaComoPropiaUnaReceta(){
		
		val persona = new Persona()
		val receta = new RecetaSimple(new RepoRecetasPropio())
		val modificacion = new modEliminarIngredientes()
		val papa = new Ingrediente(Preferencia.PAPA,100)
		val sal = new Ingrediente(Preferencia.SAL,10)
		receta.agregarIngrediente(papa)
		receta.agregarIngrediente(sal)
		receta.calorias=400
		
		modificacion.ingrediente = new Ingrediente(Preferencia.SAL)
		
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertTrue(persona.tieneXRecetasPropias(1))
	}	

	@Test
	
	def void unaPersonaQueEliminaIngredienteDeUnaRecetaPublicaIncorporaComoPropiaUnaRecetaConMenosIngredientes(){
		
		val persona = new Persona()
		val receta = new RecetaSimple(new RepoRecetasPropio())
		receta.nombre = "papasALaCrema"
		val modificacion = new modEliminarIngredientes()
		val papa = new Ingrediente(Preferencia.PAPA,100)
		val crema = new Ingrediente(Preferencia.CREMA,25)
		val sal = new Ingrediente(Preferencia.SAL,10)
		receta.agregarIngrediente(papa)
		receta.agregarIngrediente(crema)
		receta.agregarIngrediente(sal)
		receta.calorias=600
		
		modificacion.ingrediente = new Ingrediente(Preferencia.SAL)
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertTrue(persona.tieneXRecetasPropias(1))
		Assert.assertEquals(2, persona.cantidadIngredientesReceta("papasALaCrema"))
	}
	
		@Test
	
	def void unaPersonaQueAgregaIngredienteDeUnaRecetaPublicaIncorporaComoPropiaUnaRecetaConMasIngredientes(){
		
		val persona = new Persona()
		val receta = new RecetaSimple(new RepoRecetasPropio())
		receta.nombre = "papasALaCrema"
		val modificacion = new modAgregarIngredientes()
		val papa = new Ingrediente(Preferencia.PAPA,100)
		val crema = new Ingrediente(Preferencia.CREMA,25)
		receta.agregarIngrediente(papa)
		receta.agregarIngrediente(crema)
		receta.calorias=600
		
		modificacion.ingrediente = new Ingrediente(Preferencia.SAL,10)
		persona.modificarReceta(receta,modificacion)
		
		Assert.assertTrue(persona.tieneXRecetasPropias(1))
		Assert.assertEquals(3, persona.cantidadIngredientesReceta("papasALaCrema"))
	}
	
	
	@Test (expected = NoEsValidoException)
	
	def void unaRecetaSimpleNoPuedeTenerSubrecetas(){
		val repositorio= new RepoRecetasPropio()
		var recetaSimple1 = new RecetaSimple(repositorio)
		var recetaSimple2 = new RecetaSimple(repositorio)
		
		recetaSimple1.agregarIngrediente(new Ingrediente(Preferencia.POLLO, 1))
		recetaSimple2.agregarIngrediente(new Ingrediente(Preferencia.PAPA, 8))
		
		recetaSimple1.agregarSubreceta(recetaSimple2)
		
		Assert.assertTrue(recetaSimple1.tieneIngrediente(Preferencia.PAPA))
	}
	
	@Test
	
	def void unaRecetaCompuestaReutilizaDosRecetasSimples(){
		val repositorio = new RepoRecetasPropio()
		var recetaSimple1 = new RecetaSimple(repositorio)
		var recetaSimple2 = new RecetaSimple(repositorio)
		var recetaCompuesta = new RecetaCompuesta(repositorio)

		recetaSimple1.agregarIngrediente(new Ingrediente(Preferencia.POLLO, 1))
		recetaSimple1.agregarIngrediente(new Ingrediente(Preferencia.OREGANO, 10))
		recetaSimple2.agregarIngrediente(new Ingrediente(Preferencia.PAPA, 5))
		recetaSimple2.agregarIngrediente(new Ingrediente(Preferencia.MANTECA, 1))
		
		recetaCompuesta.agregarSubreceta(recetaSimple1)
		recetaCompuesta.agregarSubreceta(recetaSimple2)
		
		Assert.assertTrue(recetaCompuesta.tieneIngrediente(Preferencia.POLLO))		
		Assert.assertTrue(recetaCompuesta.tieneIngrediente(Preferencia.OREGANO))
		Assert.assertTrue(recetaCompuesta.tieneIngrediente(Preferencia.PAPA))
		Assert.assertTrue(recetaCompuesta.tieneIngrediente(Preferencia.MANTECA))

	}	
	
	@Test
	
	def void unaRecetaCompuestaReutilizaUnaRecetaSimpleYOtraCompuesta(){
		
		val repositorio = new RepoRecetasPropio()
		var recetaSimple1 = new RecetaSimple(repositorio)
		var recetaSimple2 = new RecetaSimple(repositorio)
		var recetaSimple3 = new RecetaSimple(repositorio)
		var recetaCompuesta = new RecetaCompuesta(repositorio)
		var recetaCompuestaNivel2 = new RecetaCompuesta(repositorio)

		recetaSimple1.agregarIngrediente(new Ingrediente(Preferencia.POLLO, 1))
		recetaSimple1.agregarIngrediente(new Ingrediente(Preferencia.OREGANO, 10))
		recetaSimple2.agregarIngrediente(new Ingrediente(Preferencia.PAPA, 5))
		recetaSimple2.agregarIngrediente(new Ingrediente(Preferencia.MANTECA, 1))
		recetaSimple3.agregarIngrediente(new Ingrediente(Preferencia.ARROZ, 5))
		recetaSimple3.agregarIngrediente(new Ingrediente(Preferencia.SALSADESOJA, 1))
		
		recetaCompuesta.agregarSubreceta(recetaSimple1)
		recetaCompuesta.agregarSubreceta(recetaSimple2)
		
		recetaCompuestaNivel2.agregarSubreceta(recetaCompuesta)
		recetaCompuestaNivel2.agregarSubreceta(recetaSimple3)
		
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente(Preferencia.POLLO))		
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente(Preferencia.OREGANO))
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente(Preferencia.PAPA))
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente(Preferencia.MANTECA))
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente(Preferencia.ARROZ))
		Assert.assertTrue(recetaCompuestaNivel2.tieneIngrediente(Preferencia.SALSADESOJA))

	}
		
	
		
	@Test
	
	def unaPersonaPuedeVerLaRecetaDeUnCompañeroDeGrupo(){
		val persona = new Persona()
		val persona2= new Persona()
		val grupo = new GrupoDePersonas("Los Pibes")
		val receta = new RecetaSimple(persona)
		
		grupo.agregarAGrupo(persona)
		grupo.agregarAGrupo(persona2)
		
		receta.agregarIngrediente(new Ingrediente(Preferencia.SAL,10))
		receta.agregarIngrediente(new Ingrediente(Preferencia.CARNE,100))
		receta.calorias=150
		persona.agregarReceta(receta)
		
		Assert.assertTrue(receta.puedeVerOModificarReceta(persona2))
		
	}
	
	@Test
	
	def unaRecetaQueNoContieneIngredientesQueLeDisgutenAUnaPersonaNiIngredientesQueNoSeanPermitidosPorSusCondicionesPreexistentesPuedeSerSugeridaAEsaPersona(){	
		val persona = new Persona()
		persona.nombre = "Paul"
		persona.agregarCondPreexistente(new Vegano)
		persona.agregarDisgusto(Preferencia.CARNE)
		val receta = new RecetaSimple(new RepoRecetasPropio())
		receta.agregarIngrediente(new Ingrediente(Preferencia.PAPA,100))
		receta.agregarIngrediente(new Ingrediente(Preferencia.SAL,10))
		
		Assert.assertTrue(receta.puedeSerSugeridaA(persona))	
		
	}			
	
	@Test

	def unaRecetaQueContieneIngredientesQueLeDisgutenAUnaPersonaNoPuedeSerSurgeridaAEsaPersona(){
		val persona = new Persona()
		persona.nombre = "Paul"
		persona.agregarCondPreexistente(new Vegano)
		persona.agregarDisgusto(Preferencia.PAPA)
		val receta = new RecetaSimple(new RepoRecetasPropio())
		receta.agregarIngrediente(new Ingrediente(Preferencia.PAPA,100))
		receta.agregarIngrediente(new Ingrediente(Preferencia.SAL,10))
		
		Assert.assertFalse(receta.puedeSerSugeridaA(persona))
	}
	
	@Test
	def unaRecetaQueContieneIngredientesQueNoSeanPermitidosPorSusCondicionesPreexistentesNoPuedeSerSurgeridaAEsaPersona(){	
		val persona = new Persona()
		persona.nombre = "Paul"
		persona.agregarCondPreexistente(new Hipertenso)
		persona.agregarDisgusto(Preferencia.CARNE)
		val receta = new RecetaSimple(new RepoRecetasPropio())
		receta.agregarIngrediente(new Ingrediente(Preferencia.PAPA,100))
		receta.agregarIngrediente(new Ingrediente(Preferencia.SAL,10))
		
		Assert.assertFalse(receta.puedeSerSugeridaA(persona))
	}	
	
	@Test
	def unaRecetaQueContieneAlgunIngredienteQueLeGusteAlGrupoYQueNoContieneIngredientesQueNoSeanPermitidosParaAlgunIntegrantePuedeSerSugeridaAUnGrupo(){	
		val persona = new Persona()
		persona.agregarCondPreexistente(new Hipertenso)
		val persona2= new Persona()
		persona.agregarCondPreexistente(new Celiaco)
		val grupo = new GrupoDePersonas("Los Pibes")
		grupo.agregarPreferencia(Preferencia.CARNE)
		val receta = new RecetaSimple(new RepoRecetasPropio())
		
		grupo.agregarAGrupo(persona)
		grupo.agregarAGrupo(persona2)
		
		receta.agregarIngrediente(new Ingrediente(Preferencia.PAPA,10))
		receta.agregarIngrediente(new Ingrediente(Preferencia.CARNE,100))
		
		Assert.assertTrue(receta.puedeSerSugeridaA(grupo))
	}	
			
	@Test
	def unaRecetaQueNoContieneNingunIngredienteQueLeGusteAlGrupoNoPuedeSerSugeridaAEseGrupo(){	
		val persona = new Persona()
		persona.agregarCondPreexistente(new Hipertenso)
		val persona2= new Persona()
		persona.agregarCondPreexistente(new Celiaco)
		val grupo = new GrupoDePersonas("Los Pibes")
		grupo.agregarPreferencia(Preferencia.POLLO)
		val receta = new RecetaSimple(new RepoRecetasPropio())
		
		grupo.agregarAGrupo(persona)
		grupo.agregarAGrupo(persona2)
		
		receta.agregarIngrediente(new Ingrediente(Preferencia.PAPA,10))
		receta.agregarIngrediente(new Ingrediente(Preferencia.CARNE,100))
		
		Assert.assertFalse(receta.puedeSerSugeridaA(grupo))
	}
	
	@Test
	def unaRecetaQueContieneIngredientesQueNoSeanPermitidosParaAlgunIntegranteDelGrupoNoPuedeSerSugeridaAEseGrupo(){	
		val persona = new Persona()
		persona.agregarCondPreexistente(new Hipertenso)
		val persona2= new Persona()
		persona.agregarCondPreexistente(new Celiaco)
		val grupo = new GrupoDePersonas("Los Pibes")
		grupo.agregarPreferencia(Preferencia.CARNE)
		val receta = new RecetaSimple(new RepoRecetasPropio())
		
		grupo.agregarAGrupo(persona)
		grupo.agregarAGrupo(persona2)
		
		receta.agregarIngrediente(new Ingrediente(Preferencia.SAL,10))
		receta.agregarIngrediente(new Ingrediente(Preferencia.CARNE,100))
		
		Assert.assertFalse(receta.puedeSerSugeridaA(grupo))	
	}	
	
}
	

	
		
	
