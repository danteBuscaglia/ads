package dds.grupo9.queComemos

import org.junit.Assert
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.manejoResultadosFiltros.OrdenarPorCriterio
import dds.grupo9.queComemos.manejoResultadosFiltros.Busqueda
import dds.grupo9.queComemos.ordenamientoResultados.CriterioPorCalorias
import dds.grupo9.queComemos.filtros.FiltroPorCondicionesPreexistentes
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio
import dds.grupo9.queComemos.manejoResultadosFiltros.ConsiderarRecetasPares
import org.junit.Test
import dds.grupo9.queComemos.manejoResultadosFiltros.ObtenerLosDiezPrimeros

class BusquedaTestSuite {
	def void unaPersonaPuedeObtenerLosDiezPrimerosResultadosDeUnaBusqueda(){
		val repositorio = new RepoRecetasPropio()
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
		
		val busqueda = new Busqueda()
		busqueda.fuenteDeDatos = filtro		
		val diezPrimeros = new ObtenerLosDiezPrimeros()
		busqueda.proceso = diezPrimeros
		
		persona.setRepoRecetas(repositorio)
		persona.agregarCondPreexistente(new Hipertenso()) 
		filtro.persona = persona
		filtro.decorado = persona
		receta1.agregarIngrediente(new Ingrediente("caldo"))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente())
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
		repositorio.agregarRecetaPublica(receta2)
		persona.agregarReceta(receta3)
		repositorio.agregarRecetaPublica(receta4)
		repositorio.agregarRecetaPublica(receta5)
		persona.agregarReceta(receta6)
		repositorio.agregarRecetaPublica(receta7)
		repositorio.agregarRecetaPublica(receta8)
		persona.agregarReceta(receta9)
		repositorio.agregarRecetaPublica(receta10)
		repositorio.agregarRecetaPublica(receta11)
		persona.agregarReceta(receta12)
		
		Assert.assertEquals(busqueda.resultado.size,10)
	}
	
	@Test
	
	def void unaPersonaPuedeObtenerSoloLas5RecetasParesDeUnaBusquedaQueDevuelve10Resultados(){
		val repositorio = new RepoRecetasPropio()
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
		
		val busqueda = new Busqueda()
		busqueda.fuenteDeDatos = filtro		
		val procesoPares = new ConsiderarRecetasPares()
		busqueda.proceso = procesoPares
		
		persona.setRepoRecetas(repositorio)
		persona.agregarCondPreexistente(new Hipertenso()) 
		filtro.persona = persona
		filtro.decorado = persona
		receta1.agregarIngrediente(new Ingrediente("caldo"))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente("sal"))
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
		repositorio.agregarRecetaPublica(receta2)
		persona.agregarReceta(receta3)
		repositorio.agregarRecetaPublica(receta4)
		repositorio.agregarRecetaPublica(receta5)
		persona.agregarReceta(receta6)
		repositorio.agregarRecetaPublica(receta7)
		repositorio.agregarRecetaPublica(receta8)
		persona.agregarReceta(receta9)
		repositorio.agregarRecetaPublica(receta10)
		repositorio.agregarRecetaPublica(receta11)
		persona.agregarReceta(receta12)

		
		Assert.assertEquals(busqueda.resultado.size,5)
	}
	
	@Test
	
	def void unaPersonaPuedeOrdenarLosResultadosDeUnaBusquedaSegunSusCalorias(){
		val repositorio = new RepoRecetasPropio()
		val persona = new Persona()
		val filtro = new FiltroPorCondicionesPreexistentes()
		val receta1 = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(persona)
		val receta4 = new RecetaSimple(repositorio)
		val receta5 = new RecetaSimple(persona)
		val criterioCal = new CriterioPorCalorias()
		
		val busqueda = new Busqueda()
		busqueda.fuenteDeDatos = filtro		
		val ordenar = new OrdenarPorCriterio(criterioCal)
		busqueda.proceso = ordenar
		
		persona.setRepoRecetas(repositorio)
		persona.agregarCondPreexistente(new Hipertenso()) 
		filtro.persona = persona
		filtro.decorado = persona
		receta1.agregarIngrediente(new Ingrediente())
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente("sal"))
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		receta4.agregarIngrediente(new Ingrediente())
		receta4.calorias = 550
		receta5.agregarIngrediente(new Ingrediente())
		receta5.calorias = 350
		persona.agregarReceta(receta1)
		repositorio.agregarRecetaPublica(receta2)
		persona.agregarReceta(receta3)
		repositorio.agregarRecetaPublica(receta4)
		persona.agregarReceta(receta5)
		
		val recetasOrdenadas = #[receta3,receta5,receta4,receta1]
		
		Assert.assertEquals(busqueda.resultado, recetasOrdenadas)	
	}
	
}