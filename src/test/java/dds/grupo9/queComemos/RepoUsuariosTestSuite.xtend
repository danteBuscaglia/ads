package dds.grupo9.queComemos

import org.junit.Assert
import dds.grupo9.queComemos.repoUsuarios.RepoUsuarios
import dds.grupo9.queComemos.excepciones.NoEsValidoException
import org.junit.Test
import dds.grupo9.queComemos.repoUsuarios.BuilderPersona
import dds.grupo9.queComemos.excepciones.NoLoTieneException
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.condicionPreexistente.Diabetico

class RepoUsuariosTestSuite {
	// ENTREGA 3 TEST
	
	  @Test (expected = NoEsValidoException)
	  
	  def void unaPersonaSolicitaElIngresoAlSistemaPeroEsUnUsuarioNoValido(){
	  	
	  	val repoUsuarios = new RepoUsuarios()
	  	
	  	val builder = new BuilderPersona()
	  	builder.asignarNombre("juani")
	  	repoUsuarios.solicitarIngreso(builder.build)
	  	
	  }
	
	
	
       @Test
       
       def void unaPersonaEsAceptadaPorElAdministradorYElRepoLaEncuentraPorSuNombre(){
       	
       val repoUsuarios = new RepoUsuarios()
       val builder = new BuilderPersona()
      
       builder.asignarNombre("juani")
       builder.asignarAltura(1.70f)
       builder.asignarPeso(70f)
       builder.asignarRutina("Crossfit")
       builder.asignarFechaNacimiento(19901010)
       var juani = builder.build
       repoUsuarios.solicitarIngreso(juani)
       repoUsuarios.aceptarUsuario(juani)
       
       Assert.assertEquals(juani,repoUsuarios.get(juani))
       
       
    }
     @Test
     
     def void unaPersonaEsRechazadaPorElAdministradorYElRepoLaGuardaComoRechazada(){
     	val repoUsuarios = new RepoUsuarios()
     	val builder = new BuilderPersona()
        builder.asignarNombre("juani")
        builder.asignarAltura(1.70f)
        builder.asignarPeso(70f)
        builder.asignarRutina("Crossfit")
        builder.asignarFechaNacimiento(19901010)
        var juani =builder.build
      
        repoUsuarios.solicitarIngreso(juani)
        repoUsuarios.rechazarUsuario(juani,"No cumple con los requisitos de peso mínimo")
        
        Assert.assertEquals(1,repoUsuarios.cantidadRechazados)
     	
     }
     
     @Test
     
     def void seActualizanLosDatosDeUnaPersonaRegistradaEnElRepoYElRegistroDelRepoSufreLasModificaciones(){
     	
     	val repoUsuarios = new RepoUsuarios()
     	val builder = new BuilderPersona()
        builder.asignarNombre("juani")
        builder.asignarAltura(1.70f)
        builder.asignarPeso(70f)
        builder.asignarRutina("Crossfit")
        builder.asignarFechaNacimiento(19901010)
        var juani = builder.build
        
        repoUsuarios.solicitarIngreso(juani)
        repoUsuarios.aceptarUsuario(juani)
        
        builder.asignarNombre("juani")
        builder.asignarAltura(1.60f)
        builder.asignarPeso(75f)
        builder.asignarRutina("Atletismo")
        builder.asignarFechaNacimiento(19901010)
        var juaniActualizado = builder.build
 
        repoUsuarios.update(juaniActualizado)
      
        
        Assert.assertEquals(juaniActualizado,repoUsuarios.get(juani))
        
     }
   
    @Test (expected = NoLoTieneException)
    
    def void noSePuedenActualizarLosDatosDeUnaPersonaQueNoEsUnUsuarioRegistrado(){
    	val repoUsuarios = new RepoUsuarios()
    	val builder = new BuilderPersona()
        builder.asignarNombre("juani")
        builder.asignarAltura(1.70f)
        builder.asignarPeso(70f)
        builder.asignarRutina("Crossfit")
        builder.asignarFechaNacimiento(19901010)
        var juani = builder.build
        
        repoUsuarios.solicitarIngreso(juani)
        
        builder.asignarNombre("juani")
        builder.asignarAltura(1.60f)
        builder.asignarPeso(75f)
        builder.asignarRutina("Atletismo")
        builder.asignarFechaNacimiento(19901010)
        var juaniActualizado = builder.build
       
        repoUsuarios.update(juaniActualizado)
        
   }
	@Test
	def void seListanTodasLasPersonasConMismoNombreYDiabeticasRegistradas(){
        val repoUsuarios = new RepoUsuarios()
        val builder = new BuilderPersona
        val diabetico = new Diabetico()
        val hipertenso = new Hipertenso()
   		
   		builder.asignarNombre("juani")
        builder.asignarAltura(1.70f)
        builder.asignarPeso(70f)
        builder.asignarRutina("Crossfit")
        builder.asignarSexo("Masculino")
        builder.asignarUnGusto("carne")
        builder.asignarFechaNacimiento(19901010)
   		builder.asignarUnaCondicionPreexistente(diabetico)
   		var juani = builder.build
   		repoUsuarios.solicitarIngreso(juani)
   		repoUsuarios.aceptarUsuario(juani)
   		
   		builder.asignarNombre("juani")
        builder.asignarAltura(1.60f)
        builder.asignarPeso(75f)
        builder.asignarRutina("Atletismo")
        builder.asignarSexo("Masculino")
        builder.asignarFechaNacimiento(19901010)
        builder.asignarUnGusto("pescado")
   		builder.asignarUnaCondicionPreexistente(diabetico)
   		var juani2 = builder.build
   		repoUsuarios.solicitarIngreso(juani2)
   		repoUsuarios.aceptarUsuario(juani2)
   		
   		builder.asignarNombre("juani")
   		builder.asignarAltura(1.82f)
   		builder.asignarPeso(72f)
   		builder.asignarSexo("Masculino")
   		builder.asignarRutina("Crossfit")
   		builder.asignarUnGusto("chori")
   		builder.asignarFechaNacimiento(19901010)
   		builder.asignarUnaCondicionPreexistente(hipertenso)
   		var juani3 = builder.build
   		repoUsuarios.solicitarIngreso(juani3)
   		repoUsuarios.aceptarUsuario(juani3)

   		Assert.assertEquals(2, repoUsuarios.list(juani).size)
   	
   }
   
   	@Test
	def void seListanTodasLasPersonasConMismoNombreSinImportarLaCondicionPreexistentePorqueElPrototipoNoTieneNinguna(){
   		val repoUsuarios = new RepoUsuarios()
   		val builder = new BuilderPersona
   		
   		builder.asignarNombre("juani")
        builder.asignarAltura(1.70f)
        builder.asignarPeso(70f)
        builder.asignarRutina("Crossfit")
        builder.asignarFechaNacimiento(19901010)
        var juani = builder.build
   		repoUsuarios.solicitarIngreso(juani)
   		repoUsuarios.aceptarUsuario(juani)
   		
   		builder.asignarNombre("juani")
        builder.asignarAltura(1.60f)
        builder.asignarPeso(75f)
        builder.asignarRutina("Atletismo")
        builder.asignarFechaNacimiento(19901010)
        var juani2 = builder.build
   		repoUsuarios.solicitarIngreso(juani2)
   		repoUsuarios.aceptarUsuario(juani2)

   		Assert.assertEquals(2,repoUsuarios.list(juani).size)
   	
   }
}