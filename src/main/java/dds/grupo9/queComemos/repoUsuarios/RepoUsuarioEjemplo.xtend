package dds.grupo9.queComemos.repoUsuarios

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.repoRecetas.RepoRecetasEjemplo
import org.uqbar.commons.utils.Observable
import java.util.Collection

@Observable
class RepoUsuarioEjemplo extends RepoUsuarios {
	
	var BuilderPersona builder;
	@Accessors Collection<Persona> usuarios
	@Accessors Persona persona1
	@Accessors Persona persona2
	@Accessors Persona persona3
	@Accessors RepoRecetasEjemplo repositorioRecetas
	
	new(){
		//crear y configurar personas
		builder.asignarAltura(1.70f)
       	builder.asignarPeso(70f)
      	builder.asignarRutina("Crossfit")
       	builder.asignarFechaNacimiento(19901010)
      	builder.asignarSexo("Masculino")
      	builder.repoRecetas = repositorioRecetas
		persona1 = builder.build
		persona2 = builder.build
		persona3 = builder.build
		persona1.nombre = "Persona 1"
		persona2.nombre = "Persona 2"
		persona3.nombre = "Persona 3"
		
		usuarios.add(persona1)
		usuarios.add(persona2)
		usuarios.add(persona3)
	}

}