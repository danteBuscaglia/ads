package dds.grupo9.queComemos.procesosPeriodicos

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Mail
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.EnviadorDeMail
import dds.grupo9.queComemos.consultas.Consulta

class EnviarMails implements ProcesoPeriodico {
	
	var Collection<Mail> mails = newHashSet()
	@Accessors EnviadorDeMail enviador
	@Accessors Persona administrador
	
	override ejecutar(){
		
		mails.forEach[m|enviador.enviar(m,administrador.getMail())]
	}
	
	override actualizar(Persona persona, Collection<Consulta> filtrosAplicados, Collection<Receta> recetas) {
		if(persona.estaConfiguradaParaRecibirMails()){
			agregarMailAPendientes(filtrosAplicados,recetas.size,administrador.getMail)
		}
	}
	
	def tieneXMails(){
		mails.size()
	}
	
	def getMails(){
		mails
	}
   	
   	def agregarMailAPendientes(Collection<Consulta> filtrosAplicados, int cantResultados, String direccion){
   		var Mail mail = new Mail
   		mail.setFiltrosAplicados(filtrosAplicados)
   		mail.setCantResultados(cantResultados)
   		mail.setDestino(direccion)
   		mails.add(mail)
   	}
}