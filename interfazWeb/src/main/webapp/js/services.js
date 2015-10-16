var recetarioService = recetarioApp.service('recetarioService',[ '$http',
	    function($http) {
	      this.login = function(body){
	    	  return $http.post('/login', body);
	      };	
		
	      this.getAll = function() {
	        return $http.get('/recetas');
	      };
	     
	      
	      this.getRecetaActual = function() {
	        return $http.get('/recetaActual');
	      };
	      
	      this.getIngredientes = function(){
	    	  return $http.get('/ingredientes');
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
	      
		  this.filtrar = function(){
			  return $http.post('/filtradas', body);
		  }
	    }]);