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
	def void unaPersonaConIMCPromedioSubsanaTodasLasCondicionesPreexistentes()
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
	def void unaPersonaConIMCPromedioNoSubsanaHipertension()
	{
		var persona = new Persona()
		
		persona.peso = 74.0f
		persona.altura = 1.79f
		
		persona.agregarCondPreexistente(new Hipertenso())

		persona.rutina = "LEVE"
		
		Assert.assertFalse(persona.sigueRutinaSaludable)
		
	}
	
	@Test
	def void unaPersonaConIMCPromedioNoSubsanaVeganismo()
	{
		var persona = new Persona()
		
		persona.peso = 74.0f
		persona.altura = 1.79f
		
		persona.agregarCondPreexistente(new Vegano())

		persona.agregarPreferencia(Preferencia.VERDURA)
		
		Assert.assertFalse(persona.sigueRutinaSaludable)
		
	}
	
	@Test
	def void unaPersonaConIMCPromedioNoSubsanaDiabetes()
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
		val receta = new Receta()
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias=500
		
		
		Assert.assertTrue(persona.agregarReceta(receta))
		
	}
	
	@Test
	
	def void unaPersonaNoPuedeAgregarUnaReceta(){
		
		val persona= new Persona()
		val receta = new Receta()
		receta.agregarIngrediente(new Ingrediente())
		receta.calorias=50000
		
		Assert.assertFalse(persona.agregarReceta(receta))
		
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
	def void unaPersonaNacioDepuesDelDiaDeLaFecha()
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
	
	
		
	
}