package dds.grupo9.queComemos

import org.junit.Test
import dds.grupo9.queComemos.logueo.LoggerConsultas
import dds.grupo9.queComemos.consultas.Consulta
import java.util.Collection
import dds.grupo9.queComemos.consultas.ConsultaPorDisgusto
import dds.grupo9.queComemos.consultas.ConsultaPorCaloriasMaximas
import dds.grupo9.queComemos.consultas.ConsultaPorCondicionesPreexistentes
import dds.grupo9.queComemos.consultas.ConsultaPorIngredientesCaros

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
		var Collection<Consulta> col = newHashSet();
		col.add(new ConsultaPorCaloriasMaximas(30));
		col.add(new ConsultaPorCondicionesPreexistentes());
		col.add(new ConsultaPorDisgusto());
		col.add(new ConsultaPorIngredientesCaros());
		santi.nombre = "Santiago";
		logger.loguearConsulta(santi, col, 10);
	}
}