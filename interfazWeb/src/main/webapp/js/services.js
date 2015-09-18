var recetarioService = recetarioApp.service('recetarioService', [ '$http',
    function($http) {
      this.getAll = function() {
        return $http.get('/recetas');
      };
      this.detalleReceta = function(receta) {
        return $http.post('/detalleReceta', receta);
      };
      this.getRecetaActual = function() {
        return $http.get('/recetaActual');
      };
    }]);