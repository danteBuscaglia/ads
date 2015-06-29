package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.consultas.Consulta
import java.util.Collection

class Mail {
	
	var Collection<Consulta> filtrosAplicados
	@Accessors int cantResultados
	@Accessors String destino
	
	def setFiltrosAplicados(Collection<Consulta> consultas) {
		return filtrosAplicados.addAll(consultas)
	}
	
	def getFiltrosAplicados(){
		
		return filtrosAplicados
	}
}