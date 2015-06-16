package dds.grupo9.queComemos

import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import org.junit.Assert
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio
import dds.grupo9.queComemos.filtros.FiltroPorCondicionesPreexistentes
import dds.grupo9.queComemos.filtros.FiltroPorIngredientesCaros
import org.junit.Test
import dds.grupo9.queComemos.filtros.FiltroPorDisgusto
import dds.grupo9.queComemos.filtros.FiltroPorCaloriasMaximas

class FiltroTestSuite {
	@Test
	
	def void unaPersonaConSobrepesoConsultaSusRecetasYNoObtieneLasQueTienenMasDe500Calorias(){
		val repositorio = new RepoRecetasPropio()
		val persona = new Persona()
		val filtro = new FiltroPorCaloriasMaximas(30)
		val receta1 = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(persona)
		
		persona.setRepoRecetas(repositorio)
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
		repositorio.agregarRecetaPublica(receta2)
		persona.agregarReceta(receta3)
		
		Assert.assertEquals(41.52f, persona.imc, 0.05f)
		Assert.assertEquals(2, persona.recetasPropias.size)
		Assert.assertEquals(2, filtro.resultado.size)
	}
	
	@Test
	
	def void unaPersonaRealizaUnFiltroPorSusCondicionesPreexistentes(){
		val repositorio = new RepoRecetasPropio()
		val persona = new Persona()
		val filtro = new FiltroPorCondicionesPreexistentes()
		val receta1 = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(persona)
		
		persona.setRepoRecetas(repositorio)
		persona.agregarCondPreexistente(new Hipertenso())
		filtro.decorado = persona
		filtro.persona = persona
		receta1.agregarIngrediente(new Ingrediente("sal"))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente())
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		persona.agregarReceta(receta1)
		repositorio.agregarRecetaPublica(receta2)
		persona.agregarReceta(receta3)
		

		Assert.assertEquals(filtro.resultado.size,2)
	}
	
	@Test
	
	def void unaPersonaNoObtieneComoResultadoDeLaBusquedaLasRecetasQueNoLeGustan(){
		val repositorio = new RepoRecetasPropio()
		val persona = new Persona()
		val filtro = new FiltroPorDisgusto()
		val receta1 = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(persona)
		
		persona.setRepoRecetas(repositorio)
		persona.agregarDisgusto("pescado")
		filtro.persona = persona
		filtro.decorado = persona
		receta1.agregarIngrediente(new Ingrediente("pescado"))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente())
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		persona.agregarReceta(receta1)
		repositorio.agregarRecetaPublica(receta2)
		persona.agregarReceta(receta3)
		
		Assert.assertEquals(filtro.resultado.size,2)
	}
	
	@Test
	
	def void aUnaPersonaRataNoSeLeMuestranLasRecetasConIngredientesCaros(){
		val repositorio = new RepoRecetasPropio()
		val persona = new Persona()
		val filtro = new FiltroPorIngredientesCaros()
		val receta1 = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(persona)
		
		persona.setRepoRecetas(repositorio)
		filtro.persona = persona
		filtro.decorado = persona
		receta1.agregarIngrediente(new Ingrediente("lomo"))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente())
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		persona.agregarReceta(receta1)
		repositorio.agregarRecetaPublica(receta2)
		persona.agregarReceta(receta3)
		
		Assert.assertEquals(filtro.resultado.size,2)
	}
	
	@Test
	
	def void unaPersonaPuedeCombinarVariosFiltrosDistintos(){
		val repositorio = new RepoRecetasPropio()
		val persona = new Persona()
		val filtro1 = new FiltroPorCondicionesPreexistentes()
		val filtro2 = new FiltroPorIngredientesCaros()
		val receta1 = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(persona)
		
		persona.setRepoRecetas(repositorio)
		persona.agregarCondPreexistente(new Hipertenso()) 
		filtro1.persona = persona
		filtro2.persona = persona
		filtro1.decorado = persona
		filtro2.decorado = filtro1
		receta1.agregarIngrediente(new Ingrediente("lomo"))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente("sal"))
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		persona.agregarReceta(receta1)
		repositorio.agregarRecetaPublica(receta2)
		persona.agregarReceta(receta3)
		
		Assert.assertEquals(filtro2.resultado.size,1)
	}	
	
}