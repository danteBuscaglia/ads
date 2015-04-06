package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors

class Persona {
	
	@Accessors float peso	/* Peso de un Usuario */
	@Accessors float altura /* Altura de un Usuario */
	

	def float imc(){		/* IMC: índice de masa corporal, calculado como (peso/estatura^2) */
		peso / Math.pow((this.altura),2) as float
	}
		
}