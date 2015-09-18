'use strict';

recetarioApp.config(function($stateProvider, $urlRouterProvider) {

	$urlRouterProvider.otherwise("/login");
	
  $stateProvider
//    .state('redirect', {
//      url: '/redirect',
//      controller: 'RedirectController as redirectCtrl'  
//    })
    .state('login', {
      url : '/login',
      templateUrl : 'templates/login.html',
      controller : 'LoginController as loginCtrl',
      data: {},
      resolve: {}
    })
     .state('listarRecetas', {
      url : '/listarRecetas',
      templateUrl : 'templates/listarRecetas.html',
      controller : 'ListarRecetasController as recetasCtrl',
      resolve : {
        recetasData: ['recetarioService', function(recetarioService) {
          return recetarioService.getAll();
        }]
      }
    })
//    .state('detalleReceta', {
//        url : '/detalleReceta',
//        templateUrl : 'templates/detalleReceta.html',
//        controller : 'DetalleRecetaController as detalleCtrl',
//        resolve : {
//          recetaActualData: function(recetasService) {
//            return recetasService.getRecetaActual();
//          }
//        }
//      });
    
});
