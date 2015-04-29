package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Collection

class Persona {
	
	@Accessors float peso	/* Peso de un Usuario */
	@Accessors float altura		/* Altura de un Usuario */
	@Accessors String nombre	/* Nombre de un Usuario */
	@Accessors String sexo		/* Sexo de un Usuario: M/m: Masculino y F/f: Femenino */
	@Accessors long fechaNacimiento		/* Fecha de nacimiento de un Usuario */
	var Collection<Preferencia> gustos = newHashSet() /* Gustos de un Usuario */
	var Collection<Preferencia> disgustos = newHashSet() /*Disgustos de un Usuario */
	var Collection<CondPreexistente> condicionesPreexistentes = newHashSet() /* Condicionantes de un Usuario */
	@Accessors String rutina /* Tipo de rutina que lleva a cabo el Usuario */
    var Collection<Receta> recetas= newHashSet() /*Recetas de un Usuario */
    var Collection<GrupoDePersonas> grupos = newHashSet()
        	
	new (){
		nombre = "sinNombre"
		fechaNacimiento = -1
		peso = -1
		altura = -1 
		rutina = "sinRutina"
		sexo = "sinSexo"
	}
	
	def getGustos(){
		this.gustos
	}
	
	def getDisgustos(){
		this.disgustos
	}
	
	def getRecetas(){
		this.recetas
	}
	/*Entrega 0 */		
	def float imc(){		/* IMC: índice de masa corporal, calculado como (peso/estatura^2) */
		peso / (altura**2) as float
	}
	/*Entrega 1 */
	def usuarioValido(){ /* Verifica si una persona es un Usuario válido */
		(this.completaCamposObligatorios && 
			nombre.length > 4 && 
			condicionesPreexistentes.forall[condicion | condicion.verificaDatosSegunCondicion(this)] && 
			this.fechaValida(new Fecha()))
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
	
	def void agregarReceta(Receta receta){ /*Agrega una receta a la colección si cumple con las condiciones */
	    if(receta.recetaValida){
		 	receta.duenio = this
		 	recetas.add(receta)
	 	}
	 	else throw new RuntimeException("La receta no es válida")
	}
	
	def recetaNoRecomendada(Receta receta){ /* Evalúa si dada una receta, esta es recomendada para la persona o no */
		condicionesPreexistentes.exists[c|c.recetaNoRecomendada(receta)]
	}
	
	def modificarReceta (Receta receta, Modificacion modificacion){
		if(receta.puedeVermeOModificarme(this)){
			receta.sufrirCambios(this, modificacion)
		}
		else throw new RuntimeException("No puede modificar esta receta")
	}
	
	def tienePreferencias() {
		gustos.length > 0
	}
	
	def indicaSexo() {
		sexo != "sinSexo"
	}
	
	def prefiereNoComer(Collection<Preferencia> alimentos) {
		alimentos.forall[alimento| !(gustos.contains(alimento))]
	}
	
	def fechaValida(Fecha fecha){
		fecha.actualizarFecha
		fecha.fechaDeHoy > fechaNacimiento
	}
	
	def completaCamposObligatorios(){
		(nombre != "sinNombre" && fechaNacimiento != -1 && peso != -1 && altura != -1 && rutina != "sinRutina")
	}
	
	def tieneXRecetas(int cantidadRecetas) {
		recetas.length == cantidadRecetas
	}
	
     /*Entrega 2 */
	def leCompartenLaReceta(Receta receta) {
		grupos.exists[g|g.incluyeDuenioDeReceta(receta)]
		
		}
		
	def agregarGrupo(GrupoDePersonas grupo){
		
		grupos.add(grupo)
	}
		
		 
		
	}
	
