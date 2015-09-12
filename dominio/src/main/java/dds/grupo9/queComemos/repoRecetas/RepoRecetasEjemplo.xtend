package dds.grupo9.queComemos.repoRecetas

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.Ingrediente
import dds.grupo9.queComemos.Estacion
import queComemos.entrega3.dominio.Dificultad
import dds.grupo9.queComemos.Receta
import org.uqbar.commons.utils.Observable
import dds.grupo9.queComemos.RecetaSimple
import dds.grupo9.queComemos.condicionPreexistente.Vegano
import dds.grupo9.queComemos.condicionPreexistente.Celiaco
import dds.grupo9.queComemos.condicionPreexistente.Hipertenso
import dds.grupo9.queComemos.Persona

@Observable
class RepoRecetasEjemplo extends RepoRecetasPropio {
	
	@Accessors Receta receta1
	@Accessors Receta receta2
	@Accessors Receta receta3
	@Accessors Receta receta4
	@Accessors Receta receta5
	
	new()
	{
      	receta1 = new RecetaSimple(this)
      	receta2 = new RecetaSimple(this)
      	receta3 = new RecetaSimple(this)
      	receta4 = new RecetaSimple(this)
      	receta5 = new RecetaSimple(this)
      	receta1.nombre = "Super sal"
      	receta1.agregarIngrediente(new Ingrediente("sal",10))
		receta1.calorias = 650
		receta1.agregarTemporada(Estacion.VERANO)
		receta1.dificultad = Dificultad.FACIL
		receta2.nombre = "Alto fish"
		receta2.agregarIngrediente(new Ingrediente("pescado",2))
		receta2.calorias = 420
      	receta2.agregarTemporada(Estacion.INVIERNO)
      	receta2.dificultad = Dificultad.DIFICIL
      	receta3.agregarIngrediente(new Ingrediente("lechuga",3))
		receta3.calorias = 300
		receta3.nombre = "Ensalada Cesar"
		receta3.agregarTemporada(Estacion.PRIMAVERA)
      	receta3.dificultad = Dificultad.MEDIANA
		receta4.agregarIngrediente(new Ingrediente("huevo",2))
		receta4.calorias = 550
		receta4.nombre = "Comidita"
		receta4.agregarTemporada(Estacion.OTOGNO)
      	receta4.dificultad = Dificultad.FACIL
		receta5.agregarIngrediente(new Ingrediente("lomo",1))
		receta5.calorias = 350
		receta5.nombre = "MacQueso"
		receta5.agregarTemporada(Estacion.INVIERNO)
      	receta5.dificultad = Dificultad.FACIL
      	
      	this.agregarRecetaPublica(receta1)
      	this.agregarRecetaPublica(receta2)
      	this.agregarRecetaPublica(receta3)
      	this.agregarRecetaPublica(receta4)
      	this.agregarRecetaPublica(receta5)
   	}
	
	def construirRecetaPrivada(Persona p) {
		var r = new RecetaSimple(p)
		r.nombre = "Ravioles con crema"
		r.calorias = 550
		r.dificultad = Dificultad.FACIL
		r.agregarIngrediente(new Ingrediente("harina", 500))
		r.agregarIngrediente(new Ingrediente("huevos", 3))
		r.agregarIngrediente(new Ingrediente("aceite", 3))
		r.agregarIngrediente(new Ingrediente("agua", 200))
		r.agregarIngrediente(new Ingrediente("queso azul", 200))
		r.agregarIngrediente(new Ingrediente("espinaca", 1))
		r.agregarIngrediente(new Ingrediente("jamon", 100))
		r.agregarCondimento("sal")
		r.agregarCondimento("salsa de soja")
		r.agregarCondimento("nueces")
		r.agregarTemporada(Estacion.VERANO)
		r.agregarTemporada(Estacion.OTOGNO)
		r.explicacion = "Preparar la masa mezclando el harina, los huevos, el agua y el aceite. 
		Dejar reposar. Cortar en forma de tapas circulares. Preparar relleno. 
		Armar los ravioes. Hervir, colar y servir. Poner crema, nueces y salsa de soja a gusto!!"
		p.marcarRecetaComoFavorita(r)
		return r
	}
	
}