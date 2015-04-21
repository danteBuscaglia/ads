package dds.grupo9.queComemos

import org.eclipse.xtend.lib.annotations.Accessors

class Ingrediente {
	
	@Accessors String nombre
	@Accessors int cantidad
	
	new (){
		
	}
	new (String nombreIng, int cantidadIng){
		nombre = nombreIng
		cantidad = cantidadIng
	}
	def boolean soyYo(String nombreIngrediente){ /*Devuelve true si el nombre del ingrediente es igual al pasado por parametro */
		nombre == nombreIngrediente
	}
    
    def boolean tieneMuchoAzucar(){
		soyYo("azucar") && cantidad > 100
    }
}