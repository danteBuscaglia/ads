package dds.grupo9.queComemos

import org.junit.Test
import org.junit.Assert


class PersonaTestSuite {

	@Test
	def void unaPersonaIMC(){
		val santiago = new Persona()
		
		santiago.peso = 74.0f
		santiago.altura = 1.79f
		
		Assert.assertEquals(23.10f, santiago.imc, 0.05f)
	}
	
	@Test
	def void juaniIMC()
	{
		val juani = new Persona()
		
		juani.peso = 70.0f
		juani.altura = 1.82f
		
		Assert.assertEquals(21.13f, juani.imc, 0.05f)
		
	}
	
	@Test 
	def void ignacioIMC()
	 {
	 	 val ignacio = new Persona()
	 	 
	 	 ignacio.peso = 78.0f
	 	 ignacio.altura = 1.72f
	 	 
	 	 Assert.assertEquals(26.36f, ignacio.imc, 0.05f)
	}
	
	@Test
	def void juanPabloIMC()
	{
		val juanPablo = new Persona()
		
		juanPablo.peso = 76.0f
		juanPablo.altura = 1.85f
		
		Assert.assertEquals(22.21f, juanPablo.imc, 0.01f)
	}
	
	@Test
	def void unaPersonaTieneImcPromedio()
	{
		val persona = new Persona()
		
		persona.peso = 74.0f
		persona.altura = 1.79f
		
		Assert.assertTrue(persona.tieneImcPromedio)
	}
	
	@Test
	def void unaPersonaConImcPromedioNoTieneCondicionesPreexistentesYSigueRutinaSaludable()
	{
		val persona = new Persona()
		
		persona.peso = 74.0f
		persona.altura = 1.79f
		
		Assert.assertTrue(persona.sigueRutinaSaludable)
		
	}
	
	@Test
	def void unaPersonaSinImcPromedioNoSigueRutinaSaludable()
	{
		val persona = new Persona()
		
		persona.peso = 740.0f
		persona.altura = 1.79f

		Assert.assertFalse(persona.sigueRutinaSaludable)
		
	}
	
	@Test
	def void unaPersonaConIMCPromedioYQueSubsanaTodasLasCondicionesPreexistentes()
	{
		var persona = new Persona()
		persona.peso = 74.0f
		persona.altura = 1.79f
		
		persona.agregarCondPreexistente(new Vegano())
		persona.agregarCondPreexistente(new Hipertenso())
		persona.agregarCondPreexistente(new Diabetico())
		persona.agregarCondPreexistente(new Celiaco())
		
		persona.agregarPreferencia(Preferencia.FRUTA)
		persona.rutina = "INTENSIVO"

		Assert.assertTrue(persona.sigueRutinaSaludable)
		
	}
	
	@Test
	def void unaPersonaConIMCPromedioYQueNoSubsanaHipertension()
	{
		var persona = new Persona()
		
		persona.peso = 74.0f
		persona.altura = 1.79f
		
		persona.agregarCondPreexistente(new Hipertenso())

		persona.rutina = "LEVE"
		
		Assert.assertFalse(persona.sigueRutinaSaludable)
		
	}
	
	@Test
	def void unaPersonaConIMCPromedioYQueNoSubsanaVeganismo()
	{
		var persona = new Persona()
		
		persona.peso = 74.0f
		persona.altura = 1.79f
		
		persona.agregarCondPreexistente(new Vegano())

		persona.agregarPreferencia(Preferencia.VERDURA)
		
		Assert.assertFalse(persona.sigueRutinaSaludable)
		
	}
	
	@Test
	def void unaPersonaConIMCPromedioYQueNoSubsanaDiabetes()
	{
		var persona = new Persona()
		
		persona.peso = 74.0f
		persona.altura = 1.79f
		
		persona.agregarCondPreexistente(new Diabetico())
		
		Assert.assertFalse(persona.sigueRutinaSaludable)
		
	}
	
	@Test
	def void unaPersonaAgregaUnaReceta(){
		val persona= new Persona()
		val receta = new RecetaSimple(persona)
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias=500
		persona.agregarReceta(receta)
		
		
		Assert.assertTrue(persona.tieneXRecetasPropias(1))
		
	}
	
	@Test (expected = NoEsValidoException)
	
	def void unaPersonaNoPuedeAgregarUnaReceta(){
		
		val persona= new Persona()
		val receta = new RecetaSimple(persona)
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias=50000
		persona.agregarReceta(receta)
		
		
		Assert.assertTrue(persona.tieneXRecetasPropias(1))
		
	}
	
	@Test
	def void unDiabeticoNoPuedeConsumirUnaRecetaConAzucar(){
		
		val persona = new Persona()
		val receta = new RecetaSimple(new RepoRecetas())
		val azucar = new Ingrediente()
		val diabetico = new Diabetico()
		azucar.nombre = Preferencia.AZUCAR
		azucar.cantidad = 150
		receta.agregarIngrediente(azucar)
		receta.calorias=500
		persona.agregarCondPreexistente(diabetico)
		
		Assert.assertTrue(persona.recetaNoRecomendada(receta))
	}
	
	
	
	@Test
	
	def void unVeganoYUnHipertensoNoPuedenConsumirUnaRecetaConSalYCarne(){
	
	    val receta = new RecetaSimple(new RepoRecetas())
	    val persona = new Persona()
	    val vegano= new Vegano()
	    val hipertenso = new Hipertenso()
	    
	    receta.agregarIngrediente(new Ingrediente(Preferencia.SAL,10))
	    receta.agregarIngrediente(new Ingrediente(Preferencia.CARNE,200))
	    
	    receta.calorias=400
	    
	    persona.agregarCondPreexistente(vegano)
	    persona.agregarCondPreexistente(hipertenso)
	    
	    Assert.assertTrue(persona.recetaNoRecomendada(receta))
	    	
	    
	}
	@Test
	def void unaRecetaConMuchaAzucarYSalYCarneSoloPuedeSerConsumidaPorUnCeliaco(){
		
		val persona = new Persona()
		val celiaco = new Celiaco()
		val receta = new RecetaSimple(new RepoRecetas())
		
		receta.agregarIngrediente(new Ingrediente(Preferencia.AZUCAR, 150))
		receta.agregarIngrediente(new Ingrediente(Preferencia.SAL, 15))
		receta.agregarIngrediente(new Ingrediente(Preferencia.CARNE, 300))
		
		receta.calorias=500
		
		persona.agregarCondPreexistente(celiaco)
				

		Assert.assertFalse(persona.recetaNoRecomendada(receta))		
		

	}	

	
	@Test
	def void unaPersonaEsUnUsuarioValido()
	{
		var persona = new Persona()
		
		persona.nombre = "El Enzo"
		persona.peso = 74.0f
		persona.altura = 1.79f
		persona.rutina = "INTENSIVO"
		persona.fechaNacimiento = 19611112
		persona.sexo = 'M'
		
		persona.agregarCondPreexistente(new Hipertenso())
		persona.agregarCondPreexistente(new Diabetico())
		persona.agregarCondPreexistente(new Vegano())
		persona.agregarCondPreexistente(new Celiaco())
		persona.agregarPreferencia(Preferencia.VERDURA)
		persona.agregarPreferencia(Preferencia.MELON)
		
		Assert.assertTrue(persona.usuarioValido)
		
	}
	
	@Test
	def void unaPersonaNoCompletaTodosSusDatosBasicos()
	{
		var persona = new Persona()
		
		persona.nombre = ""
		persona.peso = 74.0f
		persona.altura = 1.79f
		persona.rutina = "INTENSIVO"
		persona.fechaNacimiento = 19611112


		Assert.assertFalse(persona.usuarioValido)
		
	}

	@Test
	def void unaPersonaNacioDespuesDelDiaDeLaFecha()
	{
		var persona = new Persona()
		
		persona.nombre = "El Enzo"
		persona.peso = 74.0f
		persona.altura = 1.79f
		persona.rutina = "INTENSIVO"
		persona.fechaNacimiento = 20201212
		persona.sexo = 'M'

		Assert.assertFalse(persona.usuarioValido)
		
	}	

	@Test
	def void unaPersonaNoIndicaSexo()
	{
		var persona = new Persona()

		Assert.assertFalse(persona.indicaSexo)
		
	}	
	
	@Test
	def void unVeganoQuePrefiereComerCarneNoEsValido()
	{
		var persona = new Persona()
		
		persona.nombre = "El Enzo"
		persona.peso = 74.0f
		persona.altura = 1.79f
		persona.rutina = "INTENSIVO"
		persona.fechaNacimiento = 19611112
		persona.sexo = 'M'
		
		persona.agregarCondPreexistente(new Hipertenso())
		persona.agregarCondPreexistente(new Diabetico())
		persona.agregarCondPreexistente(new Vegano())
		persona.agregarCondPreexistente(new Celiaco())
		persona.agregarPreferencia(Preferencia.CARNE)
		persona.agregarPreferencia(Preferencia.MELON)
		
		Assert.assertFalse(persona.usuarioValido)
		
		}
	
	
	/*@Test
	def void fecha()
	{
		var Fecha fecha = new Fecha()
		fecha.actualizarFecha
		Assert.assertEquals(20150416,fecha.fechaDeHoy)
		
	}*/

	
	@Test
	
	def void unaPersonaTieneEnSuListaDeRecetasTotalesUnaRecetaPropiaYUnaRecetaPublicaYUnaRecetaDeUnCompañeroDeGrupo(){
		val persona= new Persona()
		val persona2= new Persona()
		val grupo = new GrupoDePersonas("Los Pibes")
	    grupo.agregarAGrupo(persona)
	    grupo.agregarAGrupo(persona2)
	    
	    val repositorio = new RepoRecetas()
	    persona.setRepositorio(repositorio)
	    val receta= new RecetaSimple(persona)
	    receta.agregarIngrediente(new Ingrediente(Preferencia.CARNE,100))
	    receta.calorias=500
	    persona.agregarReceta(receta)
	    val receta2= new RecetaSimple(repositorio)
	    receta2.agregarIngrediente(new Ingrediente(Preferencia.CHORI,100))
	    receta2.calorias=700
	    val receta3= new RecetaSimple(persona2)
	    receta3.agregarIngrediente(new Ingrediente(Preferencia.POLLO,100))
	    receta3.calorias=800
	    persona2.agregarReceta(receta3)
	    
	    Assert.assertEquals(3,persona.listarTodasSusRecetas.size)
	}
	
	@Test
	
	def void unaPersonaPuedeAgregarUnaRecetaComoFavoritayQuedaEnElHistorial(){
		val persona = new Persona()
		val repositorio = new RepoRecetas()
		persona.setRepositorio(repositorio)
		val receta = new RecetaSimple(repositorio)
		
		persona.marcarRecetaComoFavorita(receta)
		
		Assert.assertTrue(persona.tieneRecetaFavorita(receta))
		
	}
	
	
	@Test 
	 
	 def void unaPersonaAgregaUnaRecetaPrivadaAFavoritos (){
           
           val persona = new Persona()
           val persona2 = new Persona()
           val receta = new RecetaSimple(persona)
           receta.agregarIngrediente(new Ingrediente())
		   receta.calorias=500
           val grupo = new GrupoDePersonas("amigos")
           
           grupo.agregarAGrupo(persona)
           grupo.agregarAGrupo(persona2)
		   persona.agregarReceta(receta) 
		   receta.cambioAPrivada(persona)	
	 	   persona2.marcarRecetaComoFavorita(receta)
	 	   
	 	 Assert.assertEquals(persona2.getRecetasFavoritas.size,1)  
	 }
	    
	@Test (expected = NoPuedeAgregarException)
	
	def void unaPersonaNoPuedeAgregarUnaRecetaComoFavoritaYSaltaExcepcion(){
		val persona = new Persona()
		val persona2 = new Persona()
		val receta = new RecetaSimple (persona2)
		
		persona.marcarRecetaComoFavorita(receta)
		
		Assert.assertTrue(persona.tieneRecetaFavorita(receta))
		
	}
	
	@Test
	
	def void unaPersonaConSobrepesoConsultaSusRecetasYNoObtieneLasQueTienenMasDe500Calorias(){
		val repositorio = new RepoRecetas()
		val persona = new Persona()
		val filtro = new FiltroPorCaloriasMaximas(30)
		val receta1 = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(persona)
		
		persona.setRepositorio(repositorio)
		persona.peso = 120f
		persona.altura = 1.7f
		filtro.decorado = persona
		filtro.persona = persona
		receta1.agregarIngrediente(new Ingrediente())
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente())
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		persona.agregarReceta(receta1)
		persona.agregarReceta(receta3)
		
		Assert.assertEquals(41.52f, persona.imc, 0.05f)
		Assert.assertEquals(2, persona.recetasPropias.size)
		Assert.assertEquals(2, filtro.resultado.size)
	}
	
	@Test
	
	def void unaPersonaRealizaUnFiltroPorSusCondicionesPreexistentes(){
		val repositorio = new RepoRecetas()
		val persona = new Persona()
		val filtro = new FiltroPorCondicionesPreexistentes()
		val receta1 = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(persona)
		
		persona.setRepositorio(repositorio)
		persona.agregarCondPreexistente(new Hipertenso())
		filtro.decorado = persona
		filtro.persona = persona
		receta1.agregarIngrediente(new Ingrediente(Preferencia.SAL))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente())
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		persona.agregarReceta(receta1)
		persona.agregarReceta(receta3)
		

		Assert.assertEquals(filtro.resultado.size,2)
	}
	
	@Test
	
	def void unaPersonaNoObtieneComoResultadoDeLaBusquedaLasRecetasQueNoLeGustan(){
		val repositorio = new RepoRecetas()
		val persona = new Persona()
		val filtro = new FiltroPorDisgusto()
		val receta1 = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(persona)
		
		persona.setRepositorio(repositorio)
		persona.agregarDisgusto(Preferencia.PESCADO)
		filtro.persona = persona
		filtro.decorado = persona
		receta1.agregarIngrediente(new Ingrediente(Preferencia.PESCADO))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente())
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		persona.agregarReceta(receta1)
		persona.agregarReceta(receta3)
		
		Assert.assertEquals(filtro.resultado.size,2)
	}
	
	@Test
	
	def void aUnaPersonaRataNoSeLeMuestranLasRecetasConIngredientesCaros(){
		val repositorio = new RepoRecetas()
		val persona = new Persona()
		val filtro = new FiltroPorIngredientesCaros()
		val receta1 = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(persona)
		
		persona.setRepositorio(repositorio)
		filtro.persona = persona
		filtro.decorado = persona
		receta1.agregarIngrediente(new Ingrediente(Preferencia.LOMO))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente())
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		persona.agregarReceta(receta1)
		persona.agregarReceta(receta3)
		
		Assert.assertEquals(filtro.resultado.size,2
		)
	}
	
	@Test
	
	def void unaPersonaPuedeCombinarVariosFiltrosDistintos(){
		val repositorio = new RepoRecetas()
		val persona = new Persona()
		val filtro1 = new FiltroPorCondicionesPreexistentes()
		val filtro2 = new FiltroPorIngredientesCaros()
		val receta1 = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(persona)
		
		persona.setRepositorio(repositorio)
		persona.agregarCondPreexistente(new Hipertenso()) 
		filtro1.persona = persona
		filtro2.persona = filtro1.persona
		filtro1.decorado = persona
		filtro2.decorado = filtro1
		receta1.agregarIngrediente(new Ingrediente(Preferencia.LOMO))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente(Preferencia.SAL))
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		persona.agregarReceta(receta1)
		persona.agregarReceta(receta3)
		
		Assert.assertEquals(filtro2.resultado.size,1)
	}	

	@Test
	
	def void unaPersonaPuedeObtenerLosDiezPrimerosResultadosDeUnaBusqueda(){
		val repositorio = new RepoRecetas()
		val persona = new Persona()
		val filtro = new FiltroPorCondicionesPreexistentes()
		val receta1 = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(persona)
		val receta4 = new RecetaSimple(repositorio)
		val receta5 = new RecetaSimple(repositorio)
		val receta6 = new RecetaSimple(persona)
		val receta7 = new RecetaSimple(repositorio)
		val receta8 = new RecetaSimple(repositorio)
		val receta9 = new RecetaSimple(persona)
		val receta10 = new RecetaSimple(repositorio)
		val receta11 = new RecetaSimple(repositorio)
		val receta12 = new RecetaSimple(persona)
		
		persona.setRepositorio(repositorio)
		persona.agregarCondPreexistente(new Hipertenso()) 
		filtro.persona = persona
		filtro.decorado = persona
		receta1.agregarIngrediente(new Ingrediente(Preferencia.CALDO))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente(Preferencia.SAL))
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		receta4.agregarIngrediente(new Ingrediente())
		receta4.calorias = 500
		receta5.agregarIngrediente(new Ingrediente())
		receta5.calorias = 400
		receta6.agregarIngrediente(new Ingrediente())
		receta6.calorias = 350
		receta7.agregarIngrediente(new Ingrediente())
		receta7.calorias = 680
		receta8.agregarIngrediente(new Ingrediente())
		receta8.calorias = 470
		receta9.agregarIngrediente(new Ingrediente())
		receta9.calorias = 360
		receta10.agregarIngrediente(new Ingrediente())
		receta10.calorias = 680
		receta11.agregarIngrediente(new Ingrediente())
		receta11.calorias = 460
		receta12.agregarIngrediente(new Ingrediente())
		receta12.calorias = 320
		persona.agregarReceta(receta1)
		persona.agregarReceta(receta3)
		persona.agregarReceta(receta6)
		persona.agregarReceta(receta9)
		persona.agregarReceta(receta12)
		filtro.obtenerLosDiezPrimeros()
		
		Assert.assertEquals(filtro.resultado.size,10)
	}
}
	
