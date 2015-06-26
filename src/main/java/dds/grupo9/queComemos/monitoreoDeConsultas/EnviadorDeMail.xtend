package dds.grupo9.queComemos.monitoreoDeConsultas

import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.consultas.ConsultaDecorada
import java.util.Collection
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.Mail

class EnviadorDeMail implements ProcesoPeriodico {
	
	var Collection<Mail> mails = newHashSet()
	
	override ejecutar(){
		
		enviarMails
	}
	
	override actualizar(Persona persona, ConsultaDecorada consulta, Collection<Receta> recetas) {
		// Falta agregar condición según qué persona sea
		agregarMailAPendientes(consulta,recetas.size)
	
	}
	
   def enviarMails(){}
	
   def agregarMailAPendientes(ConsultaDecorada consulta, int cantResultados){
   	
   	var Mail mail = new Mail
   	mail.setConsulta(consulta)
   	mail.setCantResultados(cantResultados)
   	mails.add(mail)
   }
}