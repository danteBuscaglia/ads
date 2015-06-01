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
import java.util.Collection
import queComemos.entrega3.repositorio.BusquedaRecetas
import queComemos.entrega3.dominio.Dificultad
import dds.grupo9.queComemos.repoRecetas.RepoRecetasExterno
import dds.grupo9.queComemos.repoRecetas.RepoExternoAdapter
import dds.grupo9.queComemos.condicionPreexistente.Vegano

class RepoRecetasExternoTestSuit {
	
	
//ENTREGA 3 TEST
	
	@Test
	def unGetterTraeTodasLasRecetasDelRepositorioExternoEnJsonYElAdapterLaConvierteCorrectamente(){
		var repoExterno = new RepoRecetasExterno
		var Collection<dds.grupo9.queComemos.Receta> recetas = newHashSet()
		recetas = repoExterno.getRecetas()
		Assert.assertEquals(12, recetas.size)
		Assert.assertEquals("canelones de ricota y verdura", recetas.head.nombre) // NOTA: mi adaptar ordena por nombre
	}
	
	@Test
	def unFilterTraeTodasLasRecetasDelRepositorioExternoYElAdapterLaConvierteCorrectamente(){
		var repoExterno = new RepoRecetasExterno
		var Collection<dds.grupo9.queComemos.Receta> recetas = newHashSet()
		recetas = repoExterno.filterRecetas(new BusquedaRecetas())
		Assert.assertEquals(12, recetas.size)
		Assert.assertEquals("canelones de ricota y verdura", recetas.head.nombre) // NOTA: mi adaptar ordena por nombre
		Assert.assertEquals(40, recetas.head.calorias)
	}

	@Test
	def unGetterTraeAlgunasRecetasSegunUnaBusquedaEnJsonYElAdapterLaConvierteCorrectamente(){
		val busquedaRecetas = new BusquedaRecetas()
		var repoExterno = new RepoRecetasExterno
		var Collection<dds.grupo9.queComemos.Receta> recetasDevueltas = newHashSet()
		busquedaRecetas.nombre = "ensalada lechuga agridulce"
		busquedaRecetas.dificultad = Dificultad.MEDIANA
		repoExterno.busquedaRecetas = busquedaRecetas
		recetasDevueltas = repoExterno.getRecetas()
		Assert.assertEquals("ensalada lechuga agridulce", recetasDevueltas.head.nombre)
		Assert.assertEquals(Dificultad.MEDIANA,recetasDevueltas.head.dificultad)
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
		var repoExterno = new RepoRecetasExterno
		var Collection<dds.grupo9.queComemos.Receta> recetasDevueltas = newHashSet()
		busquedaRecetas.nombre = "ensalada lechuga agridulce"
		busquedaRecetas.dificultad = Dificultad.MEDIANA
		recetasDevueltas = repoExterno.filterRecetas(busquedaRecetas)
		//println(repoExterno.filterRecetas(busquedaRecetas).head)
		//println(repoExterno.filterRecetas(busquedaRecetas).head.getNombre)
		Assert.assertEquals("ensalada lechuga agridulce",recetasDevueltas.head.nombre)
		Assert.assertEquals(Dificultad.MEDIANA,recetasDevueltas.head.dificultad)
		Assert.assertEquals(4,recetasDevueltas.head.ingredientes.size)
	}
	
	/* EL REPO DE LA CÁTEDRA TIENE UN ERROR POR EL CUAL CUANDO HACE EL BUILDER ASIGNA EL TIEMPO DE PREPARACIÓN COMO CARLORÍAS */
	@Test
	
	def void unaPersonaConSobrepesoConsultaTodasLasRecetasYNoObtieneLasQueTienenMasDe500Calorias(){
		val repositorio = new RepoRecetasExterno()
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
		persona.agregarReceta(receta2)
		persona.agregarReceta(receta3)
		
		Assert.assertEquals(41.52f, persona.imc, 0.05f)
		Assert.assertEquals(3, persona.recetasPropias.size)
		Assert.assertEquals(14, filtro.resultado.size)
	}
	
	@Test
	
	def void unaPersonaRealizaUnFiltroPorSusCondicionesPreexistentes(){
		val repositorio = new RepoRecetasExterno()
		val persona = new Persona()
		val filtro = new FiltroPorCondicionesPreexistentes()
		val receta1 = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(persona)
		
		persona.setRepoRecetas(repositorio)
		persona.agregarCondPreexistente(new Vegano())
		filtro.decorado = persona
		filtro.persona = persona
		receta1.agregarIngrediente(new Ingrediente(Preferencia.CARNE))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente())
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		persona.agregarReceta(receta1)
		persona.agregarReceta(receta2)
		persona.agregarReceta(receta3)
		

		Assert.assertEquals(13, filtro.resultado.size)
		//De las 12 recetas del repo externo una tiene un tipo de carne que por dominio no es recomendada para vegano
		//Se pueden incorporar fácilmente otras restricciones de carnes pero no por la consigna no están habilitadas
	}
	
	@Test
	
	def void unaPersonaNoObtieneComoResultadoDeLaBusquedaLasRecetasQueNoLeGustan(){
		val repositorio = new RepoRecetasExterno()
		val persona = new Persona()
		val filtro = new FiltroPorDisgusto()
		val receta1 = new RecetaSimple(persona)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(persona)
		
		persona.setRepoRecetas(repositorio)
		persona.agregarDisgusto(Preferencia.PESCADO)
		persona.agregarDisgusto(Preferencia.BERBERECHOS)
		persona.agregarDisgusto(Preferencia.BOURBON)
		filtro.persona = persona
		filtro.decorado = persona
		receta1.agregarIngrediente(new Ingrediente(Preferencia.PESCADO))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente())
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		persona.agregarReceta(receta1)
		persona.agregarReceta(receta2)
		persona.agregarReceta(receta3)
		
		Assert.assertEquals(12,filtro.resultado.size) 
		// De las 12 recetas del repo externo 1 tiene berberechos y otra bourbon
	}
	
	@Test
	
	def void aUnaPersonaRataNoSeLeMuestranLasRecetasConIngredientesCaros(){
		val repositorio = new RepoRecetasExterno()
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
		persona.agregarReceta(receta2)
		persona.agregarReceta(receta3)
		
		Assert.assertEquals(12, filtro.resultado.size)
		//De las 12 recetas, hay dos recetas del repoExterno con salmón
	}
	
	@Test
	
	def void unaPersonaPuedeCombinarVariosFiltrosDistintos(){
		val repositorio = new RepoRecetasExterno()
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
		persona.agregarReceta(receta2)
		persona.agregarReceta(receta3)
		
		Assert.assertEquals(11, filtro2.resultado.size)
		// 15 recetas: 12 del repoExterno 3 locales, 1 tiene lomo, 1 tiene sal, 2 del repo tienen salmón
	}	

	@Test
	
	def void unaPersonaPuedeObtenerLosDiezPrimerosResultadosDeUnaBusqueda(){
		val repositorio = new RepoRecetasExterno()
		val persona = new Persona()
		val filtro = new FiltroPorCondicionesPreexistentes()
		val receta1 = new RecetaSimple(persona)
		val receta3 = new RecetaSimple(persona)
		val receta9 = new RecetaSimple(persona)
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
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		receta9.agregarIngrediente(new Ingrediente())
		receta9.calorias = 360
		receta12.agregarIngrediente(new Ingrediente())
		receta12.calorias = 320
		persona.agregarReceta(receta1)
		persona.agregarReceta(receta3)
		persona.agregarReceta(receta9)
		persona.agregarReceta(receta12)
		
		Assert.assertEquals(10, busqueda.resultado.size)
	}
	
	@Test
	
	def void unaPersonaPuedeObtenerSoloLas8RecetasParesDeUnaBusquedaQueDevuelve15Resultados(){
		val repositorio = new RepoRecetasExterno()
		val persona = new Persona()
		val filtro = new FiltroPorCondicionesPreexistentes()
		val receta1 = new RecetaSimple(persona)
		val receta3 = new RecetaSimple(persona)
		val receta6 = new RecetaSimple(persona)
		val receta9 = new RecetaSimple(persona)
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
		receta3.agregarIngrediente(new Ingrediente())
		receta3.calorias = 300
		receta6.agregarIngrediente(new Ingrediente())
		receta6.calorias = 350
		receta9.agregarIngrediente(new Ingrediente())
		receta9.calorias = 360
		receta12.agregarIngrediente(new Ingrediente())
		receta12.calorias = 320
		persona.agregarReceta(receta1)
		persona.agregarReceta(receta3)
		persona.agregarReceta(receta6)
		persona.agregarReceta(receta9)
		persona.agregarReceta(receta12)
		
		Assert.assertEquals(8, busqueda.resultado.size)
		// 12 del RepoExterno + 5 internas - 1 que se filtan = 15. 
		// Vector arranca en 0 => [0,14] = 0, 2, 4, 6, 8, 10, 12, 14
	}
	
	@Test
	
	def void unaPersonaPuedeOrdenarLosResultadosDeUnaBusquedaSegunSusCalorias(){
		val repositorio = new RepoRecetasExterno()
		val persona = new Persona()
		val filtro = new FiltroPorDisgusto()
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
		persona.agregarDisgusto(Preferencia.POLLO)
		persona.agregarDisgusto(Preferencia.SAL)
		persona.agregarDisgusto(Preferencia.SALMON)
		persona.agregarDisgusto(Preferencia.LECHUGA)	
		persona.agregarDisgusto(Preferencia.AJO)		
		persona.agregarDisgusto(Preferencia.PAPA)
		persona.agregarDisgusto(Preferencia.TOMILLO)
		persona.agregarDisgusto(Preferencia.ALBAHACA)
		persona.agregarDisgusto(Preferencia.RICOTA)	
		persona.agregarDisgusto(Preferencia.ALGA)
		persona.agregarDisgusto(Preferencia.AZUCAR)
		persona.agregarDisgusto(Preferencia.HELADO_DE_CHOCOLATE)				
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
		persona.agregarReceta(receta2)
		persona.agregarReceta(receta3)
		persona.agregarReceta(receta4)
		persona.agregarReceta(receta5)
		
		val recetasOrdenadas = #[receta3,receta5,receta4,receta1]
		
		Assert.assertEquals(busqueda.resultado, recetasOrdenadas)	
		// Filtramos por disgustos quedándonos sólo con las recetas que creamos en el test
		// Comparamos contra una collection ordenada de las mismas
	}
}