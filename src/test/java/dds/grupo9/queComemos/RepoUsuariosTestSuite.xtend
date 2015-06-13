package dds.grupo9.queComemos

import org.junit.Before
import dds.grupo9.queComemos.repoUsuarios.BuilderPerfil
import dds.grupo9.queComemos.excepciones.NoEsValidoException
import org.junit.Test
import dds.grupo9.queComemos.repoUsuarios.RepoUsuarios
import org.junit.Assert

class RepoUsuariosTestSuite {
	
	var Persona juani
	
	@Before
	
	def void setUp(){
		
		juani = new BuilderPerfil().asignarNombre("juani").asignarFechaNacimiento(19942412).
		asignarPeso(67f).asignarAltura(1.82f).asignarRutina("Atletismo").build
		
	}
	
	@Test (expected = NoEsValidoException)
	  
	  def void unaPersonaSolicitaElIngresoAlSistemaPeroEsUnUsuarioNoValido(){
	  	
	  	val repoUsuarios = new RepoUsuarios()
	  	var builderPerfil = new BuilderPerfil()
	  	builderPerfil.build()
	  	builderPerfil.asignarNombre("juani")
	  	
	  	repoUsuarios.solicitarIngreso(builderPerfil.getPerfilUsuario)
	  	
	  }
	
	
	
       @Test
       
       def void unaPersonaEsAceptadaPorElAdministradorYElRepoLaEncuentraPorSuNombre(){
       	
       val repoUsuarios = new RepoUsuarios()
       this.setUp
       repoUsuarios.solicitarIngreso(juani)
       repoUsuarios.aceptarUsuario(juani)
       
       Assert.assertEquals(juani,repoUsuarios.get(juani))
       
       
    }
     @Test
     
     def void unaPersonaEsRechazadaPorElAdministradorYElRepoLaGuardaComoRechazada(){
     	val repoUsuarios = new RepoUsuarios()
        var juani = new Persona()
        repoUsuarios.generarNuevoPerfil
        repoUsuarios.asignarNombre("juani")
        repoUsuarios.asignarAltura(1.70f)
        repoUsuarios.asignarPeso(20f)
        repoUsuarios.asignarRutina("Crossfit")
        repoUsuarios.asignarFechaNacimiento(19901010)
        juani = repoUsuarios.perfilUsuario
        repoUsuarios.solicitarIngreso
        repoUsuarios.rechazarUsuario(juani,"No cumple con los requisitos de peso mínimo")
        
        Assert.assertEquals(1,repoUsuarios.cantidadRechazados)
     	
     }
     
     @Test
     
     def void seActualizanLosDatosDeUnaPersonaRegistradaEnElRepoYElRegistroDelRepoSufreLasModificaciones(){
     	
     	val repoUsuarios = new RepoUsuarios()
        var juani = new Persona
        repoUsuarios.generarNuevoPerfil
        repoUsuarios.asignarNombre("juani")
        repoUsuarios.asignarAltura(1.70f)
        repoUsuarios.asignarPeso(72f)
        repoUsuarios.asignarRutina("Crossfit")
        repoUsuarios.asignarFechaNacimiento(19901010)
        juani = repoUsuarios.perfilUsuario
        repoUsuarios.solicitarIngreso
        repoUsuarios.aceptarUsuario(juani)
        var juaniActualizado = new Persona()
        repoUsuarios.generarNuevoPerfil
        repoUsuarios.asignarNombre("juani")
        repoUsuarios.asignarAltura(1.60f)
        repoUsuarios.asignarPeso(75f)
        repoUsuarios.asignarRutina("Atletismo")
        repoUsuarios.asignarFechaNacimiento(19901010)
        juaniActualizado = repoUsuarios.perfilUsuario
        repoUsuarios.update(juaniActualizado)
      
        
        Assert.assertEquals(juaniActualizado,repoUsuarios.get(juani))
        
     }
   
    @Test (expected = NoLoTieneException)
    
    def void noSePuedenActualizarLosDatosDeUnaPersonaQueNoEsUnUsuarioRegistrado(){
    	val repoUsuarios = new RepoUsuarios()
        var juani = new Persona
        repoUsuarios.generarNuevoPerfil
        repoUsuarios.asignarNombre("juani")
        repoUsuarios.asignarAltura(1.70f)
        repoUsuarios.asignarPeso(72f)
        repoUsuarios.asignarRutina("Crossfit")
        repoUsuarios.asignarFechaNacimiento(19901010)
        juani = repoUsuarios.perfilUsuario
        repoUsuarios.solicitarIngreso
        var juaniActualizado = new Persona()
        repoUsuarios.generarNuevoPerfil
        repoUsuarios.asignarNombre("juani")
        repoUsuarios.asignarAltura(1.60f)
        repoUsuarios.asignarPeso(75f)
        repoUsuarios.asignarRutina("Atletismo")
        repoUsuarios.asignarFechaNacimiento(19901010)
        juaniActualizado = repoUsuarios.perfilUsuario
        repoUsuarios.update(juaniActualizado)
        
   }
	@Test
	def void seListanTodasLasPersonasConMismoNombreYDiabeticasRegistradas(){
        val repoUsuarios = new RepoUsuarios()
   		var juani = new Persona()
   		var juani2 = new Persona()
   		var juani3 = new Persona()
   		val hipertenso = new Hipertenso()
   		val diabetico = new Diabetico()
   		repoUsuarios.generarNuevoPerfil
   		repoUsuarios.asignarNombre("juani")
   		repoUsuarios.asignarAltura(1.82f)
   		repoUsuarios.asignarPeso(72f)
   		repoUsuarios.asignarSexo("Masculino")
   		repoUsuarios.asignarRutina("Crossfit")
   		repoUsuarios.asignarUnGusto("chori")
   		repoUsuarios.asignarFechaNacimiento(19901010)
   		repoUsuarios.asignarUnaCondicionPreexistente(diabetico)
   		repoUsuarios.solicitarIngreso
   		juani = repoUsuarios.perfilUsuario
   		repoUsuarios.aceptarUsuario(juani)
   		
   		repoUsuarios.generarNuevoPerfil
   		repoUsuarios.asignarNombre("juani")
   		repoUsuarios.asignarAltura(1.99f)
   		repoUsuarios.asignarPeso(92f)
   		repoUsuarios.asignarSexo("Masculino")
   		repoUsuarios.asignarRutina("Atletismo")
   		repoUsuarios.asignarUnGusto("pescado")
   		repoUsuarios.asignarFechaNacimiento(19800408)
   		repoUsuarios.asignarUnaCondicionPreexistente(diabetico)
   		repoUsuarios.solicitarIngreso
   		juani2 = repoUsuarios.perfilUsuario
   		repoUsuarios.aceptarUsuario(juani2)
   		
   		repoUsuarios.generarNuevoPerfil
   		repoUsuarios.asignarNombre("juani")
   		repoUsuarios.asignarAltura(1.82f)
   		repoUsuarios.asignarPeso(72f)
   		repoUsuarios.asignarSexo("Masculino")
   		repoUsuarios.asignarRutina("Crossfit")
   		repoUsuarios.asignarUnGusto("chori")
   		repoUsuarios.asignarFechaNacimiento(19901010)
   		repoUsuarios.asignarUnaCondicionPreexistente(hipertenso)
   		repoUsuarios.solicitarIngreso
   		juani3 = repoUsuarios.perfilUsuario
   		repoUsuarios.aceptarUsuario(juani3)

   		Assert.assertEquals(2,repoUsuarios.list(juani).size)
   	
   }
   
   	@Test
	def void seListanTodasLasPersonasConMismoNombreSinImportarLaCondicionPreexistentePorqueElPrototipoNoTieneNinguna(){
   		val repoUsuarios = new RepoUsuarios()
   		var juani = new Persona()
   		var juani2 = new Persona()
   		repoUsuarios.generarNuevoPerfil
   		repoUsuarios.asignarNombre("juani")
   		repoUsuarios.asignarAltura(1.82f)
   		repoUsuarios.asignarPeso(72f)
   		repoUsuarios.asignarRutina("Crossfit")
   		repoUsuarios.asignarFechaNacimiento(19901010)
   		repoUsuarios.solicitarIngreso
   		juani = repoUsuarios.perfilUsuario
   		repoUsuarios.aceptarUsuario(juani)
   		
   		repoUsuarios.generarNuevoPerfil
   		repoUsuarios.asignarNombre("juani")
   		repoUsuarios.asignarAltura(1.99f)
   		repoUsuarios.asignarPeso(92f)
   		repoUsuarios.asignarRutina("Atletismo")
   		repoUsuarios.asignarFechaNacimiento(19800408)
   		repoUsuarios.solicitarIngreso
   		juani2 = repoUsuarios.perfilUsuario
   		repoUsuarios.aceptarUsuario(juani2)

   		Assert.assertEquals(2,repoUsuarios.list(juani).size)
   	
   }
}