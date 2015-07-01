package dds.grupo9.queComemos.procesosPeriodicos

import org.apache.log4j.Logger

import org.apache.log4j.Logger
import org.apache.log4j.PropertyConfigurator
import org.apache.log4j.FileAppender
import org.apache.log4j.ConsoleAppender
import org.apache.log4j.PatternLayout
import java.io.OutputStreamWriter
import java.util.Collection
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.consultas.Consulta
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.consultas.ConsultaDecorada
import java.util.ArrayList
import java.util.List

class LoggerConsultas implements ProcesoPeriodico{

	private final static Logger log = Logger.getLogger(LoggerConsultas.getClass());
	List<String> logsPendientes = new ArrayList();
	new(){
		
	}
	
	def public void logueoDePrueba() {
		/*var ConsoleAppender ca = new ConsoleAppender();
		ca.setWriter(new OutputStreamWriter(System.out));
		ca.setLayout(new PatternLayout("%-5p [%t]: %m%n"));
		log.addAppender(ca);*/
		
		//BasicConfigurator.configure()
		//log.addAppender(new FileAppender)
		
 		PropertyConfigurator.configure(this.getClass().getResource("log4j.properties"))
 		log.trace("Este es un mensaje de Trace")
 		log.info("Este es un mensaje de Info")
  		log.warn("Este es un mensaje de Warning")
  		log.error("Este es un mensaje de Error")
  		log.fatal("Este es un mensaje de Fatal")
	}
	
	def public void logueoPendiente(Persona persona, Collection<Consulta> filtrosAplicados, Collection<Receta> resultados){
			PropertyConfigurator.configure(this.getClass().getResource("log4j.propiedadesLogueoConsulta"))
			var String filtrosAplicadosString = "";
			for(consulta:filtrosAplicados){
				if(consulta == filtrosAplicados.head)
				{
					filtrosAplicadosString = consulta.toString();
				}
				else
				{
					filtrosAplicadosString = filtrosAplicadosString + ", " + consulta.toString();	
				}
			}
			filtrosAplicadosString = filtrosAplicadosString + ".";
			var String logPendiente = "Consulta realizada por " + persona.nombre + ". Arrojó " + resultados.size() + " resultados. Filtros aplicados: " + filtrosAplicadosString;
			logsPendientes.add(logPendiente)
	}
	
	override ejecutar() {
		logsPendientes.forEach[log.warn(it)];
	}
	
	
	override actualizar(Persona persona, Collection<Consulta> filtrosAplicados, Collection<Receta> recetas) {
		if(recetas.size()>10){
			this.logueoPendiente(persona, filtrosAplicados, recetas);
		}
	}
	
	def getLogsPendientes(){
		logsPendientes
	}
}