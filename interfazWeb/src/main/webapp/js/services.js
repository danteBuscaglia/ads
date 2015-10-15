var recetarioService = recetarioApp.service('recetarioService',[ '$http',
	    function($http) {
	      this.login = function(body){
	    	  return $http.post('/login', body);
	      };	
		
	      this.getAll = function() {
	        return $http.get('/recetas');
	      };
	      
	      this.detalleReceta = function(receta) {
	        return $http.post('/detalleReceta', receta);
	      };
	      
	      this.getRecetaActual = function() {
	        return $http.get('/recetaActual');
	      };
	      
	      this.esFavorita = function(receta){
	    	return  
	      };
		  
	      this.getUsuario = function() {
		        return $http.get('/usuario');
		  };
		  
		  this.getConsultas = function() {
		        return $http.get('/consultas');
		  };
		  
		  this.traerRecetasMasConsultadas = function(){
			    return $http.get('/consultas2');
		  };
	      
	    }]);