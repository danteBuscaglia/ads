package dds.grupo9.queComemos

import org.junit.Assert
import dds.grupo9.queComemos.condicionPreexistente.Vegano
import dds.grupo9.queComemos.manejoResultadosFiltros.Busqueda
import dds.grupo9.queComemos.filtros.FiltroPorIngredientesCaros
import dds.grupo9.queComemos.filtros.FiltroPorCondicionesPreexistentes
import dds.grupo9.queComemos.filtros.FiltroPorDisgusto
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadasPorSexo
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio
import java.util.Collection
import org.junit.Test
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas
import dds.grupo9.queComemos.monitoreoDeConsultas.VeganosQueConsultanRecetasDificiles
import dds.grupo9.queComemos.repoRecetas.RepoRecetasExterno
import java.util.Calendar
import dds.grupo9.queComemos.monitoreoDeConsultas.ConsultasPorHora

class MonitoreoDeConsultasTestSuite {
	@Test
	
	def void saberCuantasConsultasSeHiceronEnUnaDeterminadaHora(){
		val repositorio = new RepoRecetasExterno()
		val persona = new Persona()
		val persona2 = new Persona()
		val persona3 = new Persona()
		val filtro2 = new FiltroPorDisgusto()
		val filtro3 = new FiltroPorCondicionesPreexistentes()
		val filtro = new FiltroPorIngredientesCaros()
		var consultasPorHora = new ConsultasPorHora()
		val busqueda1 = new Busqueda()
		busqueda1.fuenteDeDatos = filtro
		busqueda1.persona = persona
		val busqueda2 = new Busqueda()
		busqueda2.fuenteDeDatos = filtro2
		busqueda2.persona = persona2
		val busqueda3 = new Busqueda()
		busqueda3.fuenteDeDatos = filtro3
		busqueda3.persona = persona3
		
		persona.setRepoRecetas(repositorio)
		persona2.setRepoRecetas(repositorio)
		persona3.setRepoRecetas(repositorio)
		persona2.agregarCondPreexistente(new Vegano())
		persona2.agregarDisgusto("mejillones")
		persona2.agregarDisgusto("ricota")
		persona3.agregarCondPreexistente(new Vegano())
		filtro.persona = persona
		filtro.decorado = persona
		filtro2.persona = persona2
		filtro2.decorado = persona2
		filtro3.persona = persona3
		filtro3.decorado = persona3
		busqueda1.agregarMonitor(consultasPorHora)
		busqueda2.agregarMonitor(consultasPorHora)
		busqueda3.agregarMonitor(consultasPorHora)
				
		Assert.assertEquals(10, busqueda1.resultadoSinProcesar.size)
		Assert.assertEquals(10, busqueda2.resultadoSinProcesar.size)
		Assert.assertEquals(11, busqueda3.resultadoSinProcesar.size)
		
		Assert.assertEquals(3, consultasPorHora.obtenerConsultasPorHora(Calendar.getInstance().get(Calendar.HOUR_OF_DAY)))
	}
  
   @Test
	
	def void saberCuantosVeganosConsultaronRecetasDificiles(){
		val repositorio = new RepoRecetasExterno()
		val persona = new Persona()
		val persona2 = new Persona()
		val persona3 = new Persona()
		val filtro2 = new FiltroPorDisgusto()
		val filtro3 = new FiltroPorCondicionesPreexistentes()
		val filtro = new FiltroPorIngredientesCaros()
		var veganosDificiles = new VeganosQueConsultanRecetasDificiles()
		val busqueda1 = new Busqueda()
		busqueda1.fuenteDeDatos = filtro
		busqueda1.persona = persona
		val busqueda2 = new Busqueda()
		busqueda2.fuenteDeDatos = filtro2
		busqueda2.persona = persona2
		val busqueda3 = new Busqueda()
		busqueda3.fuenteDeDatos = filtro3
		busqueda3.persona = persona3
		
		persona.setRepoRecetas(repositorio)
		persona2.setRepoRecetas(repositorio)
		persona3.setRepoRecetas(repositorio)
		persona2.agregarCondPreexistente(new Vegano())
		persona2.agregarDisgusto("mejillones")
		persona2.agregarDisgusto("ricota")
		persona3.agregarCondPreexistente(new Vegano())
		filtro.persona = persona
		filtro.decorado = persona
		filtro2.persona = persona2
		filtro2.decorado = persona2
		filtro3.persona = persona3
		filtro3.decorado = persona3
		busqueda1.agregarMonitor(veganosDificiles)
		busqueda2.agregarMonitor(veganosDificiles)
		busqueda3.agregarMonitor(veganosDificiles)
		
		Assert.assertEquals(10, busqueda1.resultadoSinProcesar.size)
		Assert.assertEquals(10, busqueda2.resultadoSinProcesar.size)
		Assert.assertEquals(11, busqueda3.resultadoSinProcesar.size)
		
		Assert.assertEquals(1, veganosDificiles.cantidadDeVeganosQueConsultaronRecetasDificiles())
	}
   
   @Test
	
	def void obtenerLasRecetasMasConsultadasLuegoDeUnaSerieDeConsultas(){
		val repositorio = new RepoRecetasPropio()
		val persona = new Persona()
		val persona2 = new Persona()
		val persona3 = new Persona()
		val filtro3 = new FiltroPorDisgusto()
		val filtro2 = new FiltroPorCondicionesPreexistentes()
		val filtro = new FiltroPorIngredientesCaros()
		var recetasMC = new RecetasMasConsultadas()
		val busqueda1 = new Busqueda()
		busqueda1.fuenteDeDatos = filtro
		busqueda1.persona = persona
		val busqueda2 = new Busqueda()
		busqueda2.fuenteDeDatos = filtro2
		busqueda2.persona = persona2
		val busqueda3 = new Busqueda()
		busqueda3.fuenteDeDatos = filtro3
		busqueda3.persona = persona3
		
		val receta1 = new RecetaSimple(repositorio)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(repositorio)
		val receta4 = new RecetaSimple(repositorio)
		val receta5 = new RecetaSimple(repositorio)
		receta1.agregarIngrediente(new Ingrediente("pollo"))
		receta1.calorias = 650
		receta1.nombre = "Pollo a la parrilla"
		receta2.agregarIngrediente(new Ingrediente("salmon"))
		receta2.calorias = 420
		receta2.nombre = "Sushi"
		receta3.agregarIngrediente(new Ingrediente("lechuga"))
		receta3.calorias = 300
		receta3.nombre = "Ensalada Cesar"
		receta4.agregarIngrediente(new Ingrediente())
		receta4.calorias = 550
		receta4.nombre = "Comidita"
		receta5.agregarIngrediente(new Ingrediente())
		receta5.calorias = 350
		receta5.nombre = "MacQueso"
		repositorio.agregarRecetaPublica(receta1)
		repositorio.agregarRecetaPublica(receta2)
		repositorio.agregarRecetaPublica(receta3)
		repositorio.agregarRecetaPublica(receta4)
		repositorio.agregarRecetaPublica(receta5)
		
		persona.setRepoRecetas(repositorio)
		persona2.setRepoRecetas(repositorio)
		persona3.setRepoRecetas(repositorio)
		persona3.agregarDisgusto("salmon")
		persona3.agregarDisgusto("lechuga")
		persona2.agregarCondPreexistente(new Vegano())
		filtro.persona = persona
		filtro.decorado = persona
		filtro2.persona = persona2
		filtro2.decorado = persona2
		filtro3.persona = persona3
		filtro3.decorado = persona3
		busqueda1.agregarMonitor(recetasMC)
		busqueda2.agregarMonitor(recetasMC)
		busqueda3.agregarMonitor(recetasMC)
		
		var Collection<String> recetasMasConsultadas = newHashSet()
		recetasMasConsultadas.addAll("MacQueso", "Comidita", "Pollo a la parrilla")
				
		Assert.assertEquals(4, busqueda1.resultadoSinProcesar.size)
		Assert.assertEquals(4, busqueda2.resultadoSinProcesar.size)
		Assert.assertEquals(3, busqueda3.resultadoSinProcesar.size)
		
		Assert.assertEquals(recetasMasConsultadas, recetasMC.recetasMasConsultadas(3))
	}	
	
	@Test
	
	def void obtenerLasRecetasMasConsultadasPorMujeresLuegoDeUnaSerieDeConsultas(){
		val repositorio = new RepoRecetasPropio()
		val persona = new Persona()
		val persona2 = new Persona()
		val persona3 = new Persona()
		val persona4 = new Persona()
		val filtro4 = new FiltroPorDisgusto()
		val filtro3 = new FiltroPorDisgusto()
		val filtro2 = new FiltroPorCondicionesPreexistentes()
		val filtro = new FiltroPorIngredientesCaros()
		var recetasMCPS = new RecetasMasConsultadasPorSexo()
		persona.setSexo("M")
		persona2.setSexo("F")
		persona3.setSexo("m")
		persona4.setSexo("f")
		val busqueda1 = new Busqueda()
		busqueda1.fuenteDeDatos = filtro
		busqueda1.persona = persona
		val busqueda2 = new Busqueda()
		busqueda2.fuenteDeDatos = filtro2
		busqueda2.persona = persona2
		val busqueda3 = new Busqueda()
		busqueda3.fuenteDeDatos = filtro3
		busqueda3.persona = persona3
		val busqueda4 = new Busqueda()
		busqueda4.fuenteDeDatos = filtro4
		busqueda4.persona = persona4
		
		val receta1 = new RecetaSimple(repositorio)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(repositorio)
		val receta4 = new RecetaSimple(repositorio)
		val receta5 = new RecetaSimple(repositorio)
		receta1.agregarIngrediente(new Ingrediente("pollo"))
		receta1.calorias = 650
		receta1.nombre = "Pollo a la parrilla"
		receta2.agregarIngrediente(new Ingrediente("salmon"))
		receta2.calorias = 420
		receta2.nombre = "Sushi"
		receta3.agregarIngrediente(new Ingrediente("lechuga"))
		receta3.calorias = 300
		receta3.nombre = "Ensalada Cesar"
		receta4.agregarIngrediente(new Ingrediente("huevo"))
		receta4.calorias = 550
		receta4.nombre = "Comidita"
		receta5.agregarIngrediente(new Ingrediente())
		receta5.calorias = 350
		receta5.nombre = "MacQueso"
		repositorio.agregarRecetaPublica(receta1)
		repositorio.agregarRecetaPublica(receta2)
		repositorio.agregarRecetaPublica(receta3)
		repositorio.agregarRecetaPublica(receta4)
		repositorio.agregarRecetaPublica(receta5)
		
		persona.setRepoRecetas(repositorio)
		persona2.setRepoRecetas(repositorio)
		persona3.setRepoRecetas(repositorio)
		persona4.setRepoRecetas(repositorio)
		persona3.agregarDisgusto("salmon")
		persona3.agregarDisgusto("lechuga")
		persona4.agregarDisgusto("huevo")
		persona2.agregarCondPreexistente(new Vegano())
		filtro.persona = persona
		filtro.decorado = persona
		filtro2.persona = persona2
		filtro2.decorado = persona2
		filtro3.persona = persona3
		filtro3.decorado = persona3
		filtro4.persona = persona4
		filtro4.decorado = persona4
		busqueda1.agregarMonitor(recetasMCPS)
		busqueda2.agregarMonitor(recetasMCPS)
		busqueda3.agregarMonitor(recetasMCPS)
		busqueda4.agregarMonitor(recetasMCPS)
							
		var recetasMasConsultadasPM = newHashSet()
		recetasMasConsultadasPM.addAll("MacQueso", "Ensalada Cesar", "Sushi")
		
		Assert.assertEquals(4, busqueda1.resultadoSinProcesar.size)
		Assert.assertEquals(4, busqueda2.resultadoSinProcesar.size)
		Assert.assertEquals(3, busqueda3.resultadoSinProcesar.size)
		Assert.assertEquals(4, busqueda4.resultadoSinProcesar.size)
		
		Assert.assertEquals(recetasMasConsultadasPM, recetasMCPS.recetasMasConsultadasPorMujeres(3))
	}
	
	@Test
	
	def void obtenerLasRecetasMasConsultadasPorHombresLuegoDeUnaSerieDeConsultas(){
		val repositorio = new RepoRecetasPropio()
		val persona = new Persona()
		val persona2 = new Persona()
		val persona3 = new Persona()
		val persona4 = new Persona()
		val filtro4 = new FiltroPorDisgusto()
		val filtro3 = new FiltroPorDisgusto()
		val filtro2 = new FiltroPorCondicionesPreexistentes()
		val filtro = new FiltroPorIngredientesCaros()
		var recetasMCPS = new RecetasMasConsultadasPorSexo()
		persona.setSexo("M")
		persona2.setSexo("F")
		persona3.setSexo("m")
		persona4.setSexo("f")
		val busqueda1 = new Busqueda()
		busqueda1.fuenteDeDatos = filtro
		busqueda1.persona = persona
		val busqueda2 = new Busqueda()
		busqueda2.fuenteDeDatos = filtro2
		busqueda2.persona = persona2
		val busqueda3 = new Busqueda()
		busqueda3.fuenteDeDatos = filtro3
		busqueda3.persona = persona3
		val busqueda4 = new Busqueda()
		busqueda4.fuenteDeDatos = filtro4
		busqueda4.persona = persona4
		
		val receta1 = new RecetaSimple(repositorio)
		val receta2 = new RecetaSimple(repositorio)
		val receta3 = new RecetaSimple(repositorio)
		val receta4 = new RecetaSimple(repositorio)
		val receta5 = new RecetaSimple(repositorio)
		receta1.agregarIngrediente(new Ingrediente("pollo"))
		receta1.calorias = 650
		receta1.nombre = "Pollo a la parrilla"
		receta2.agregarIngrediente(new Ingrediente("salmon"))
		receta2.calorias = 420
		receta2.nombre = "Sushi"
		receta3.agregarIngrediente(new Ingrediente("lechuga"))
		receta3.calorias = 300
		receta3.nombre = "Ensalada Cesar"
		receta4.agregarIngrediente(new Ingrediente("huevo"))
		receta4.calorias = 550
		receta4.nombre = "Comidita"
		receta5.agregarIngrediente(new Ingrediente())
		receta5.calorias = 350
		receta5.nombre = "MacQueso"
		repositorio.agregarRecetaPublica(receta1)
		repositorio.agregarRecetaPublica(receta2)
		repositorio.agregarRecetaPublica(receta3)
		repositorio.agregarRecetaPublica(receta4)
		repositorio.agregarRecetaPublica(receta5)
		
		persona.setRepoRecetas(repositorio)
		persona2.setRepoRecetas(repositorio)
		persona3.setRepoRecetas(repositorio)
		persona4.setRepoRecetas(repositorio)
		persona3.agregarDisgusto("salmon")
		persona3.agregarDisgusto("lechuga")
		persona4.agregarDisgusto("huevo")
		persona2.agregarCondPreexistente(new Vegano())
		filtro.persona = persona
		filtro.decorado = persona
		filtro2.persona = persona2
		filtro2.decorado = persona2
		filtro3.persona = persona3
		filtro3.decorado = persona3
		filtro4.persona = persona4
		filtro4.decorado = persona4
		busqueda1.agregarMonitor(recetasMCPS)
		busqueda2.agregarMonitor(recetasMCPS)
		busqueda3.agregarMonitor(recetasMCPS)
		busqueda4.agregarMonitor(recetasMCPS)
							
		var recetasMasConsultadasPH = newHashSet()
		recetasMasConsultadasPH.addAll("MacQueso", "Comidita", "Pollo a la parrilla")
		
		
		Assert.assertEquals(4, busqueda1.resultadoSinProcesar.size)
		Assert.assertEquals(4, busqueda2.resultadoSinProcesar.size)
		Assert.assertEquals(3, busqueda3.resultadoSinProcesar.size)
		Assert.assertEquals(4, busqueda4.resultadoSinProcesar.size)
		
		Assert.assertEquals(recetasMasConsultadasPH, recetasMCPS.recetasMasConsultadasPorHombres(3))
		
	}
}