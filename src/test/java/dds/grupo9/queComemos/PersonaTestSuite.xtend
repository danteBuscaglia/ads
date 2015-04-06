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
	
}