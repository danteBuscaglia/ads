package dds.grupo9.queComemos.repoRecetas

import queComemos.entrega3.dominio.Receta
import dds.grupo9.queComemos.RecetaSimple
import java.util.Collection
import dds.grupo9.queComemos.Ingrediente
import java.util.ArrayList
import java.util.List
import dds.grupo9.queComemos.Preferencia
import com.google.gson.reflect.TypeToken
import com.google.gson.Gson
import java.lang.reflect.Type

class RepoExternoAdapter {

	def RecetaSimple adaptarReceta(RepoRecetasExterno repoExterno, Receta receta) {
		var RecetaSimple recetaAux = new RecetaSimple(repoExterno)
		recetaAux.nombre = receta.getNombre
		recetaAux.tiempoPreparacion = receta.getTiempoPreparacion
		recetaAux.calorias = receta.getTotalCalorias
		recetaAux.dificultad = receta.getDificultadReceta
		recetaAux.agregarTodosLosIngredientes(this.adaptarIngredientes(receta))
		recetaAux
	}
	
	def Collection <Ingrediente> adaptarIngredientes(Receta receta) {
		var Collection<Ingrediente> ingredientes = newHashSet()
		var List<String> ingredientesParaAdaptar = new ArrayList()
		ingredientesParaAdaptar = receta.getIngredientes
		for(ingredienteParaAdaptar : ingredientesParaAdaptar){
			ingredientes.add(new Ingrediente(this.adaptarNombreIngrediente(ingredienteParaAdaptar)))
		}
		ingredientes
	}
	
	def Preferencia adaptarNombreIngrediente(String string) {
		Preferencia.valueOf(string.replaceAll(" ", "_").toUpperCase)
	}
	
	def Collection<dds.grupo9.queComemos.Receta> adaptarJson(RepoRecetasExterno repoExterno,String json) {
		var Collection <dds.grupo9.queComemos.Receta> recetasPropias = newHashSet()
		var List<Receta>recetasExternas = new ArrayList()
		var Type typeOfT = new TypeToken<Collection<Receta>>(){}.getType();
		recetasExternas = new Gson().fromJson(json, typeOfT)
		recetasPropias.addAll(recetasExternas.map[this.adaptarReceta(repoExterno,it)])
		recetasPropias
	}
	
}