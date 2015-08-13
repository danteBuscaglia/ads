package dds.grupo9.queComemos.procesosPeriodicos

import dds.grupo9.queComemos.Persona
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Mail
import org.eclipse.xtend.lib.annotations.Accessors
import dds.grupo9.queComemos.EnviadorDeMail
import dds.grupo9.queComemos.consultas.Consulta

class EnviarMails implements ProcesoPeriodico {
	
	@Accessors Mail mail
	@Accessors EnviadorDeMail enviador
	
	override ejecutar(){
		enviador.enviar(mail)
	}
	
	override actualizar(Persona persona, Collection<Consulta> filtrosAplicados, Collection<Receta> recetas) {
		if(persona.estaConfiguradaParaRecibirMails()){
			var EnviarMails mail = new EnviarMails()
			mail.setMail(new Mail(filtrosAplicados, recetas.size))
			return mail
		}
		else return null
	}
   	
}