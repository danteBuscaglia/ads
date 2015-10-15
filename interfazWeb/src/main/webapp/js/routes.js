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
        }]//,
       // recetasMasConsultadas: ['recetarioService', function(recetarioService) {
         // return recetarioService.traerRecetasMasConsultadas();
        //}]
        
      }
    })
    .state('perfilUsuario', {
      url : '/perfilUsuario',
      templateUrl : 'templates/perfilUsuario.html',
      controller : 'PerfilUsuarioController as perfilCtrl',
      resolve : {
          personaData: ['recetarioService', function(recetarioService) {
              return recetarioService.getUsuario();
            }]
         
        }
      })
    
      .state('consultas', {
      url : '/consultas',
      templateUrl : 'templates/consultas.html',
      controller : 'ConsultaRecetaController as consultaCtrl',
      resolve : {
          recetasData: ['recetarioService', function(recetarioService) {
              return recetarioService.getConsultas();
            }]
        }
      })
  
});
