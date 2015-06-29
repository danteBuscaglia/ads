package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.consultas.ConsultaDecorada
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Mail
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.EnviadorDeMail

class EnviarMails implements ProcesoPeriodico {
	
	var Collection<Mail> mails = newHashSet()
	@Accessors EnviadorDeMail enviador
	@Accessors Persona administrador
	
	override ejecutar(){
		
		mails.forEach[m|enviador.enviar(m,administrador)]
	}
	
	override actualizar(Persona persona, ConsultaDecorada consulta, Collection<Receta> recetas) {
		// Falta agregar condición según qué persona sea
		agregarMailAPendientes(consulta,recetas.size,administrador.getMail)
	
	}
	
	
   def agregarMailAPendientes(ConsultaDecorada consulta, int cantResultados, String direccion){
   	
   	var Mail mail = new Mail
   	mail.setConsulta(consulta)
   	mail.setCantResultados(cantResultados)
   	mail.setDestino(direccion)
   	mails.add(mail)
   }
}