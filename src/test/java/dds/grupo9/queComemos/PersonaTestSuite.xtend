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
		val juani= new Persona()
		
		juani.peso= 70.0f
		juani.altura= 1.82f
		
		Assert.assertEquals(21.13f, juani.imc,0.05f)
	}
	
}