var loginController = recetarioApp.controller('LoginController', [ '$scope',
  '$http', '$state', function($scope, $http, $state) {
   $scope.login = function() {
    $http.post('/login', {
     nombre : $scope.nombre
    }).success(function(data) {
     document.cookie = "usuario=" + data.nombre;
     $state.go('listarRecetas');
    });
   }
  } ]);

var listarRecetasController = recetarioApp.controller('ListarRecetasController', [
    'recetasData', '$scope', 'recetarioService', '$state',
    function(recetasData, $scope, recetarioService, $state) {
      var recetas = recetasData.data.recetas;
      $scope.recetaSeleccionada = recetas[0];
      $scope.recetas = recetasData.data.recetas;
   
      
      $scope.detalleReceta = function() {
        recetarioService.detalleReceta($scope.recetaSeleccionada)
        .success(function() {
             $state.go('detalleReceta')
            });
      };
    } ]);

//var detalleRecetaController = recetarioApp.controller('DetalleRecetaController',
//    [ '$scope', 'recetaActualData', function($scope, recetaActualData) {
//    	recetaActualData
//      $scope.recetaActual = recetaActualData.data.recetaSeleccionada;
//    } ]);
//
//]);

//var redirectController = recetarioApp.controller('RedirectController', ['$state', function($state) {
//      $state.go('login');
//}]);