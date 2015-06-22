package dds.grupo9.queComemos

import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import org.junit.Assert
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio
import dds.grupo9.queComemos.filtros.FiltroPorCondicionesPreexistentes
import dds.grupo9.queComemos.filtros.FiltroPorIngredientesCaros
import org.junit.Test
import dds.grupo9.queComemos.filtros.FiltroPorDisgusto
import dds.grupo9.queComemos.filtros.FiltroPorCaloriasMaximas
import org.junit.Before

class FiltroTestSuite {
	
	var RepoRecetasPropio repositorio;
	var Persona persona;
	var FiltroPorCondicionesPreexistentes filtro;
	var RecetaSimple receta1;
	var RecetaSimple receta2;
	var RecetaSimple receta3;
	
	@Before
	def void setup(){
		repositorio = new RepoRecetasPropio()
		persona = new Persona()
		persona.setRepoRecetas(repositorio)
		filtro = new FiltroPorCondicionesPreexistentes()
		persona.setRepoRecetas(repositorio)
		persona.peso = 120f
		persona.altura = 1.7f
		
		receta1 = new RecetaSimple(persona)
		receta2 = new RecetaSimple(repositorio)
		receta3 = new RecetaSimple(persona)
		
		receta1.agregarIngrediente(new Ingrediente("sal"))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente("pescado"))
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente("lomo"))
		receta3.calorias = 300

		persona.agregarReceta(receta1)
		repositorio.agregarRecetaPublica(receta2)
		persona.agregarReceta(receta3)

	}
	
	@Test
	
	def void unaPersonaConSobrepesoConsultaSusRecetasYNoObtieneLasQueTienenMasDe500Calorias(){
		
		val filtro = new FiltroPorCaloriasMaximas(30)
		filtro.decorado = persona
		filtro.persona = persona
		
		Assert.assertEquals(41.52f, persona.imc, 0.05f)
		Assert.assertEquals(2, persona.recetasPropias.size)
		Assert.assertEquals(2, filtro.resultado.size)
	}
	
	@Test
	
	def void unaPersonaRealizaUnFiltroPorSusCondicionesPreexistentes(){
		
		val filtro = new FiltroPorCondicionesPreexistentes()
		persona.setRepoRecetas(repositorio)
		persona.agregarCondPreexistente(new Hipertenso())
		filtro.decorado = persona
		filtro.persona = persona
		

		Assert.assertEquals(filtro.resultado.size,2)
	}
	
	@Test
	
	def void unaPersonaNoObtieneComoResultadoDeLaBusquedaLasRecetasQueNoLeGustan(){
		
		val filtro = new FiltroPorDisgusto()
		persona.setRepoRecetas(repositorio)
		persona.agregarDisgusto("pescado")
		filtro.persona = persona
		filtro.decorado = persona
		
		Assert.assertEquals(filtro.resultado.size,2)
	}
	
	@Test
	
	def void aUnaPersonaRataNoSeLeMuestranLasRecetasConIngredientesCaros(){
		
		val filtro = new FiltroPorIngredientesCaros()
		persona.setRepoRecetas(repositorio)
		filtro.persona = persona
		filtro.decorado = persona
		
		Assert.assertEquals(filtro.resultado.size,2)
	}
	
	@Test
	
	def void unaPersonaPuedeCombinarVariosFiltrosDistintos(){
		
		val filtro1 = new FiltroPorCondicionesPreexistentes()
		val filtro2 = new FiltroPorIngredientesCaros()
		persona.setRepoRecetas(repositorio)
		persona.agregarCondPreexistente(new Hipertenso()) 
		filtro1.persona = persona
		filtro2.persona = persona
		filtro1.decorado = persona
		filtro2.decorado = filtro1
		
		Assert.assertEquals(filtro2.resultado.size,1)
	}	
	
}