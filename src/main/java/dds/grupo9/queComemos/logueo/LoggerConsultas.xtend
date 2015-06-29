package dds.grupo9.queComemos.logueo

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

class LoggerConsultas{

	private final static Logger log = Logger.getLogger(LoggerConsultas.getClass());
	
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
	
	def public void loguearConsulta(Persona persona, Collection<Consulta> consultas, int cantResultados){
		PropertyConfigurator.configure(this.getClass().getResource("log4j.propiedadesLogueoConsulta"))
		var String filtrosAplicados = "";
		for(consulta:consultas){
			if(consulta == consultas.head)
			{
				filtrosAplicados = consulta.toString();
			}
			else
			{
				filtrosAplicados = filtrosAplicados + ", " + consulta.toString();	
			}
		}
		filtrosAplicados = filtrosAplicados + ".";
  		log.warn("Consulta realizada por " + persona.nombre + ". Arrojó " + cantResultados + " resultados. Filtros aplicados: " + filtrosAplicados);
	}
	
}