package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Hashtable

class RecetasMasConsultadas implements Monitor {
	
	var Hashtable<String, Integer> resultados = new Hashtable<String, Integer>()
	var Collection<String> recetas = newHashSet()
	@Accessors int valor
	
	override void update(Persona persona, Collection<Receta> recetas){
		for(receta:recetas){
			configurarTabla(resultados, receta)
		}	
	}
	
	def configurarTabla(Hashtable<String,Integer> hashtable, Receta receta){
		if(hashtable.containsKey(receta.nombre)){
			hashtable.getOrDefault(receta.nombre, valor)
			hashtable.replace(receta.nombre, valor+1)
		} else {
			hashtable.put(receta.nombre, 1)
		}
	}
	
	def recetasMasConsultadas(int cant){
		mostrarRecetasMasConsultadas(resultados, cant)
	}
	
	def mostrarRecetasMasConsultadas(Hashtable<String,Integer> hashtable, int cant){
		var Collection<String> recetasConsultadas = newHashSet()
		//hashtable.values.sort.reverse
		hashtable.forEach[k,v|recetas.add(k)]
		recetasConsultadas.addAll(recetas.take(cant))
		return recetasConsultadas
	}
	
	
	/*override void update(Persona persona, Collection<Receta> recetas){
		recetas.forEach[receta| 
			if(!recetasConsultadas.exists[r|r.nombre == receta.nombre]){	
				recetasConsultadas.add(receta)
				receta.aumentarCantidadDeVecesConsultada()
			}
			else recetasConsultadas.forEach[r| if(r.nombre == receta.nombre) r.aumentarCantidadDeVecesConsultada()]
		]
	}*/
}