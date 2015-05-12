package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors

class Ingrediente {

	@Accessors Preferencia nombre /* Para Entrega 2 */
	@Accessors int cantidad
	
	new (){
		
	}
	
	new (Preferencia nombreIng){
		nombre = nombreIng
	}
	
	new (Preferencia nombreIng, int cantidadIng){
		nombre = nombreIng
		cantidad = cantidadIng
	}
	
	
	def boolean soyYo(Preferencia nombreIngrediente){ /*Devuelve true si el nombre del ingrediente es igual al pasado por parametro */
		nombre == nombreIngrediente
	}
   
    def boolean tieneMasDeLoPermitidoDe(int cantidadMax, Ingrediente ingrediente){
		soyYo(ingrediente.nombre) && cantidad > cantidadMax
    }
    
    def esCaro(){
    	soyYo(Preferencia.LECHON) || soyYo(Preferencia.LOMO) || soyYo(Preferencia.SALMON) || soyYo(Preferencia.ALCAPARRAS)
    }
}