package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection


class Persona {
	
	@Accessors float peso	/* Peso de un Usuario */
	@Accessors float altura		/* Altura de un Usuario */
	@Accessors String nombre	/* Nombre de un Usuario */
	@Accessors boolean sexo		/* Sexo de un Usuario: T: Masculino y F: Femenino */
	@Accessors long fechaNacimiento		/* Fecha de nacimiento de un Usuario */
	val Collection<Preferencia> gustos = newHashSet() /* Gustos de un Usuario */
	val Collection<Preferencia> disgustos = newHashSet() /*Disgustos de un Usuario */
	var Collection<CondPreexistente> condicionesPreexistentes = newHashSet() /* Condicionantes de un Usuario */
	@Accessors String rutina /* Tipo de rutina que lleva a cabo el Usuario */
    val Collection<Receta> recetas= newHashSet() /*Recetas de un Usuario */
	
	def float imc(){		/* IMC: índice de masa corporal, calculado como (peso/estatura^2) */
		peso / (altura**2) as float
	}
	
	def usuarioValido(){ /* Verifica si una persona es un Usuario válido */
		/*Usuario válido cumple con:
		 - campos obligatorios: nombre, peso, altura, fecha de nacimiento, rutina
		 - el nombre tiene más de 4 caracteres
		 - si el usuario es diabético, debe indicar el sexo
		 - si el usuario es hipertenso o diabético, debe indicar al menos una preferencia
		 - si el usuario es vegano no puede aparecer ninguna de estas palabras como preferencia: “pollo”, “carne”, “chivito”, “chori”
		 - la fecha de nacimiento debe ser una fecha anterior a la del día de hoy*/
	}
	
	def sigueRutinaSaludable(){ /* Evalúa si un Usuario sigue o no una rutina saludable */
		(this.tieneImcPromedio && this.subsanaCondicionesPreexistentes)
	}
	
	def tieneImcPromedio(){ /* Evalúa si un Usuario tiene un índice de masa corporal promedio, que se da cuando el IMC está entre 18 y 30 */
		this.imc > 18 && this.imc < 30
	}
	
	def subsanaCondicionesPreexistentes(){ /* Evalúa si para cada una de las condiciones preexistentes la misma se encuentra subsanada */
		condicionesPreexistentes.forall[condicion | condicion.subsanaCondicion(gustos, rutina, peso)]
	}
	
	def agregarCondPreexistente(CondPreexistente condicion){ /* Agrega una condicion preexistente a la colección */
		condicionesPreexistentes.add(condicion)
	}
	
	def agregarPreferencia(Preferencia preferencia){ /* Agrega una preferencia a la colección */
		gustos.add(preferencia)
	}
	
	def agregarDisgusto(Preferencia preferencia){ /* Agrega una preferencia a la colección */
		disgustos.add(preferencia)
	}
	def agregarReceta(Receta receta){ /*Agrega una receta a la colección si cumple con las condiciones */
		    if(receta.recetaValida){
		 	recetas.add(receta)
		 	}
	}
}