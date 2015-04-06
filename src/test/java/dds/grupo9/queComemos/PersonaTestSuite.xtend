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
	
}