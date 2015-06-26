package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.consultas.ConsultaDecorada

class Mail {
	
	@Accessors ConsultaDecorada consulta
	@Accessors int cantResultados
}