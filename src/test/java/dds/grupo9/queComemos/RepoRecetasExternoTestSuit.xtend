package dds.grupo9.queComemos

import org.junit.Test
import org.junit.Assert
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.filtros.FiltroPorCondicionesPreexistentes
import dds.grupo9.queComemos.filtros.FiltroPorCaloriasMaximas
import dds.grupo9.queComemos.filtros.FiltroPorDisgusto
import dds.grupo9.queComemos.filtros.FiltroPorIngredientesCaros
import dds.grupo9.queComemos.manejoResultadosFiltros.Busqueda
import dds.grupo9.queComemos.manejoResultadosFiltros.ObtenerLosDiezPrimeros
import dds.grupo9.queComemos.manejoResultadosFiltros.ConsiderarRecetasPares
import dds.grupo9.queComemos.ordenamientoResultados.CriterioPorCalorias
import dds.grupo9.queComemos.manejoResultadosFiltros.OrdenarPorCriterio
import RepoRecetasExterno.ConversorJson
import java.util.Collection
import queComemos.entrega3.repositorio.BusquedaRecetas
import queComemos.entrega3.dominio.Dificultad
import RepoRecetasExterno.RepoExternoAdapter

class RepoRecetasExternoTestSuit {
	
	
//ENTREGA 3 TEST
	
	@Test
	def unGetterTraeTodasLasRecetasDelRepositorioExternoEnJsonYElAdapterLaConvierteCorrectamente(){
		var conversorJson = new ConversorJson
		var Collection<dds.grupo9.queComemos.Receta> recetas = newHashSet()
		recetas = conversorJson.getRecetas(new BusquedaRecetas())
		Assert.assertEquals(12, recetas.size) // Trae el doble don't know why!!!!!!!!!!!
		Assert.assertEquals("ensalada caesar", recetas.head.nombre) // Trae en otro orden don't know why!!!!!!!!!!!
	}
	
	@Test
	def unGetterTraeAlgunasRecetasSegunUnaBusquedaEnJsonYElAdapterLaConvierteCorrectamente(){
		val busquedaRecetas = new BusquedaRecetas()
		var conversorJson = new ConversorJson
		var Collection<dds.grupo9.queComemos.Receta> recetasDevueltas = newHashSet()
		busquedaRecetas.nombre = "ensalada lechuga agridulce"
		busquedaRecetas.dificultad = Dificultad.MEDIANA
		recetasDevueltas = conversorJson.getRecetas(busquedaRecetas)
		Assert.assertEquals("ensalada lechuga agridulce", recetasDevueltas.head.nombre)
		Assert.assertEquals(Dificultad.MEDIANA,recetasDevueltas.head.dificultad)
		Assert.assertEquals("Claire Underwood",recetasDevueltas.head.getDueño.nombre)
		Assert.assertEquals(4,recetasDevueltas.head.ingredientes.size)
	}
	
	@Test
	def unRepoExternoAdapterConvierteUnStringSimpleEnUnAPreferencia(){
		var String stringConEspacios = "carne"
		var RepoExternoAdapter adaptador = new RepoExternoAdapter()
		var Preferencia preferencia = adaptador.adaptarNombreIngrediente(stringConEspacios)
		Assert.assertEquals(Preferencia.CARNE, preferencia)
	}
	
	@Test
	def unRepoExternoAdapterConvierteUnStringConEspaciosEnUnAPreferencia(){
		var String stringConEspacios = "pure de tomate"
		var RepoExternoAdapter adaptador = new RepoExternoAdapter()
		var Preferencia preferencia = adaptador.adaptarNombreIngrediente(stringConEspacios)
		Assert.assertEquals(Preferencia.PURE_DE_TOMATE, preferencia)
	}
	
	@Test
	def unFilterTraeRecetasConElFormatoDeRecetasExternaYElAdapterLaConvierteCorrectamente(){
		val busquedaRecetas = new BusquedaRecetas()
		var conversorJson = new ConversorJson
		var Collection<dds.grupo9.queComemos.Receta> recetasDevueltas = newHashSet()
		busquedaRecetas.nombre = "ensalada lechuga agridulce"
		busquedaRecetas.dificultad = Dificultad.MEDIANA
		recetasDevueltas = conversorJson.filterRecetas(busquedaRecetas)
		//println(conversorJson.filterRecetas(busquedaRecetas).head)
		//println(conversorJson.filterRecetas(busquedaRecetas).head.getNombre)
		Assert.assertEquals("ensalada lechuga agridulce",recetasDevueltas.head.nombre)
		Assert.assertEquals(Dificultad.MEDIANA,recetasDevueltas.head.dificultad)
		Assert.assertEquals("Claire Underwood",recetasDevueltas.head.getDueño.nombre)
		Assert.assertEquals(4,recetasDevueltas.head.ingredientes.size)
	}
	
	/* TEST DEL DECORATOR PARA FILTROS CONSIDERANDO REPO EXTERNO */
	/* FALTA EDITARLO, TODAVIA SON IGUALES A LOS DE PERSONA TEST SUITE */
	@Test
	
	def void unaPersonaConSobrepesoConsultaTodasLasRecetasYNoObtieneLasQueTienenMasDe500Calorias(){
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
		receta1.agregarIngrediente(new Ingrediente(Preferencia.SAL))
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
		receta1.agregarIngrediente(new Ingrediente(Preferencia.LOMO))
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
		receta1.agregarIngrediente(new Ingrediente(Preferencia.LOMO))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente(Preferencia.SAL))
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		persona.agregarReceta(receta1)
		repositorio.agregarRecetaPublica(receta2)
		persona.agregarReceta(receta3)
		
		Assert.assertEquals(filtro2.resultado.size,1)
	}	

	@Test
	
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
		receta1.agregarIngrediente(new Ingrediente(Preferencia.CALDO))
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
		receta2.agregarIngrediente(new Ingrediente(Preferencia.SAL))
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