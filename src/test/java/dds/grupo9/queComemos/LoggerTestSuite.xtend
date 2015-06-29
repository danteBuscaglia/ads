package dds.grupo9.queComemos

import org.junit.Test
import dds.grupo9.queComemos.consultas.Consulta
import java.util.Collection
import dds.grupo9.queComemos.consultas.ConsultaPorDisgusto
import dds.grupo9.queComemos.consultas.ConsultaPorCaloriasMaximas
import dds.grupo9.queComemos.consultas.ConsultaPorCondicionesPreexistentes
import dds.grupo9.queComemos.consultas.ConsultaPorIngredientesCaros
import dds.grupo9.queComemos.procesosPeriodicos.LoggerConsultas

class LoggerTestSuite {
	
	@Test
	def unLoggerLoguea(){
		var LoggerConsultas logger = new LoggerConsultas();
		logger.logueoDePrueba();
	}
	
	@Test
	def unLoggerLogueaUnaConsulta(){
		var LoggerConsultas logger = new LoggerConsultas();
		var Persona santi = new Persona();
		var Collection<Consulta> consultas = newHashSet();
		var Collection<Receta> resultados = newHashSet();
		var ConsultaPorCaloriasMaximas ccm = new ConsultaPorCaloriasMaximas(30)
		var ConsultaPorCondicionesPreexistentes ccp = new ConsultaPorCondicionesPreexistentes()
		var ConsultaPorDisgusto cd = new ConsultaPorDisgusto()
		var ConsultaPorIngredientesCaros cic = new ConsultaPorIngredientesCaros()
		ccm.decorado = ccp;
		ccp.decorado = cd;
		cd.decorado = cic;
		cic.decorado = santi;
		
		ccm.persona = santi;
		ccp.persona = santi;
		cd.persona = santi;
		cic.persona = santi;
		
		consultas.add(ccm);
		consultas.add(ccp);
		consultas.add(cd);
		consultas.add(cic);
		santi.nombre = "Santiago";
		//logger.actualizar(santi, ccm.coleccionDeConsultas(), resultados);
	}
}