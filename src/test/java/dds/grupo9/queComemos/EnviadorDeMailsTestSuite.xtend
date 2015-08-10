package dds.grupo9.queComemos

import static org.mockito.Mockito.*;
import org.junit.Test
import dds.grupo9.queComemos.procesosPeriodicos.EnviarMails
import dds.grupo9.queComemos.consultas.ConsultaPorCondicionesPreexistentes
import dds.grupo9.queComemos.repoRecetas.RepoRecetasPropio
import dds.grupo9.queComemos.repoRecetas.RepoRecetasExterno
import org.junit.Before
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.manejoResultadosConsultas.Busqueda
import org.junit.Assert
import dds.grupo9.queComemos.consultas.ConsultaPorIngredientesCaros
import java.util.List
import dds.grupo9.queComemos.procesosPeriodicos.ProcesoPeriodico

class EnviadorDeMailsTestSuite {
	
	var RepoRecetasPropio repositorio;
	var RepoRecetasExterno repoExterno;
	var Persona persona;
	var ConsultaPorCondicionesPreexistentes filtro;
	var ConsultaPorIngredientesCaros filtro2;
	var RecetaSimple receta1;
	var RecetaSimple receta2;
	var RecetaSimple receta3;
	var RecetaSimple receta4;
	var Batch batch;
	
	@Before
	def void setup(){
		repositorio = new RepoRecetasPropio()
		repoExterno = new RepoRecetasExterno()
		persona = new Persona()
		persona.setRepoRecetas(repositorio)
		filtro = new ConsultaPorCondicionesPreexistentes()
		filtro2 = new ConsultaPorIngredientesCaros()
		persona.setRepoRecetas(repositorio)
		persona.peso = 120f
		persona.altura = 1.7f
		persona.agregarCondPreexistente(new Hipertenso())
		
		receta1 = new RecetaSimple(persona)
		receta2 = new RecetaSimple(repositorio)
		receta3 = new RecetaSimple(persona)
		receta4 = new RecetaSimple(persona)
		
		receta1.agregarIngrediente(new Ingrediente("sal"))
		receta1.calorias = 650
		receta2.agregarIngrediente(new Ingrediente("pescado"))
		receta2.calorias = 420
		receta3.agregarIngrediente(new Ingrediente("lomo"))
		receta3.calorias = 300
		receta4.agregarIngrediente(new Ingrediente("huevo"))
		receta4.calorias = 300

		persona.agregarReceta(receta1)
		repositorio.agregarRecetaPublica(receta2)
		persona.agregarReceta(receta3)
		persona.agregarReceta(receta4)
	}
	
	@Test
	def unEnviadorDeMailsEnviaMailAUnaPersonaVigilada() {
		var enviadorDeMails = mock(EnviadorDeMail)
		var enviarMails = new EnviarMails()
		//var enviarMails = new EnviarMails(enviadorDeMails, "admin@yahoo,com")
		var administrador = new Persona()
		var busqueda = new Busqueda()
		
		busqueda.fuenteDeDatos = filtro2
		busqueda.persona = persona	
		filtro.decorado = persona
		filtro.persona = persona
		filtro2.persona = persona
		filtro2.decorado = filtro

		persona.configurarParaRecibirMail()				
		enviarMails.enviador = enviadorDeMails
		enviarMails.administrador = administrador
		administrador.mail = "admin@yahoo.com"
		busqueda.agregarProcesoPeriodico(enviarMails)
		
		busqueda.resultadoSinProcesar()
		
		
		enviarMails.ejecutar()
		
		Assert.assertEquals(1, enviarMails.tieneXMails())
		verify(enviadorDeMails,times(1)).enviar(any(Mail),eq("admin@yahoo.com"))
	}
	
	@Test
	def unEnviadorDeMailsNoEnviaMailAUnaPersonaQueNoEstaVigilada() {
		var enviadorDeMails = mock(EnviadorDeMail)
		var enviarMails = new EnviarMails()
		var administrador = new Persona()
		var busqueda = new Busqueda()
		
		busqueda.fuenteDeDatos = filtro2
		busqueda.persona = persona	
		filtro.decorado = persona
		filtro.persona = persona
		filtro2.persona = persona
		filtro2.decorado = filtro
				
		enviarMails.enviador = enviadorDeMails
		enviarMails.administrador = administrador
		administrador.mail = "admin@yahoo.com"
		busqueda.agregarProcesoPeriodico(enviarMails)
		
		busqueda.resultadoSinProcesar
		enviarMails.ejecutar()
		
		
		Assert.assertEquals(0, enviarMails.tieneXMails())
		verify(enviadorDeMails, never()).enviar(any(Mail), anyString)
	}
	
	@Test
	def unMailContieneLosFiltrosAplicadosYLaCantidadDeResultadosObtenidosEnLaConsultaYElMailDeLaPersona() {
		var enviarMails = new EnviarMails()
		var administrador = new Persona()
		var busqueda = new Busqueda()
		var mail = new Mail()
		
		busqueda.fuenteDeDatos = filtro2
		busqueda.persona = persona	
		filtro.decorado = persona
		filtro.persona = persona
		filtro2.persona = persona
		filtro2.decorado = filtro
		
		mail.setFiltrosAplicadosManualmente("por ingredientes caros, por condiciones preexistentes.")
		mail.cantResultados = 2
		mail.destino = "admin@yahoo.com"
		
		enviarMails.administrador = administrador
		administrador.mail = "admin@yahoo.com"
		persona.configurarParaRecibirMail()
		busqueda.agregarProcesoPeriodico(enviarMails)
		
		busqueda.resultadoSinProcesar()
				
		Assert.assertEquals(1, enviarMails.tieneXMails())
		Assert.assertEquals(mail.destino, enviarMails.getMails.head.destino)
		Assert.assertEquals(mail.cantResultados, enviarMails.getMails.head.cantResultados)
		Assert.assertEquals(mail.filtrosAplicados, enviarMails.getMails.head.filtrosAplicados)
	}
}