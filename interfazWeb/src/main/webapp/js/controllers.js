var loginController = recetarioApp.controller('LoginController', function($scope, $http, $state,recetarioService) {
    this.login = function() {
    recetarioService.login({nombre:$scope.nombre,contrasegna:$scope.contrasegna})
     .success(function(data) {
     document.cookie = "usuario=" + data.nombre;
     $state.go('listarRecetas');
    });
   }
  } );

var listarRecetasController = recetarioApp.controller('ListarRecetasController', [
    'recetasData', '$scope', 'recetarioService', '$state',
    function(recetasData, $scope, recetarioService, $state) {
      var recetas = recetasData.data.recetas;
      $scope.recetaSeleccionada = recetas[0];
      $scope.recetas = recetasData.data.recetas;
      var mensajeSobreSeleccion = recetasData.data.mensajeCorrespondiente;
      $scope.mensajeSobreSeleccion = recetasData.data.mensajeCorrespondiente[0];
      $scope.favorita=$scope.mensajeSobreSeleccion=="Estas son tus recetas favoritas";
     // $scope.mensajeSobreCreador = $scope.RecetaSeleccionada.data.mensaje;  
      //$scope.recetasConsultadas = recetasMasConsultadas.data.recetasADevolver;
      //$scope.consultas = recetasConsultadasData.data.consultas	  
      
      $scope.verPerfil = function() {
    	  $state.go('perfilUsuario')
        };
     
        $scope.agregarIngrediente = function(){
          $state.go('nuevoIngrediente')
          
        };
      
      
        
    } ]);

var nuevoIngController = recetarioApp.controller('NuevoIngController', [
   'ingredientesTotales', '$scope', 'recetarioService', '$state', 
	function(ingredientesTotales, $scope, recetarioService, $state) {
		$scope.ingredientesRepo = ingredientesTotales.data.ingredientes;
        
    	
    } ]);

var perfilUsuarioController = recetarioApp.controller('PerfilUsuarioController', [
	  'personaData', '$scope', 'recetarioService', '$state',
	  function(personaData, $scope, recetarioService, $state) {
	    $scope.altura = personaData.data.altura;
	    $scope.peso = personaData.data.peso;
	    $scope.imc = personaData.data.imc;
	    var nombre = personaData.data.nombre;
	    $scope.nombre = personaData.data.nombre;
	    $scope.sexo = personaData.data.sexo;
	    $scope.fechaNacimiento = personaData.data.fechaNacimiento;
	    $scope.gustos = personaData.data.gustos;
	    $scope.disgustos = personaData.data.disgustos;
	    $scope.rutina = personaData.data.rutina;
	    $scope.recetasFavoritas = personaData.data.recetasFavoritas;
	    $scope.condicionesPreexistentes = personaData.data.condicionesPreexistentes;
	    $scope.complexion = personaData.data.complexion
	    if (personaData.data.imc>=18 && personaData.data.imc<=30) {
  	      $scope.myStyle={color:'green'};
  	    }
  	    if (personaData.data.imc>30) {
  	    	$scope.myStyle={color:'red'};
  	    }
  	    if (personaData.data.imc<18) {
  	    	$scope.myStyle={color:'orange'};
  	    }
	    
	    this.volver = function() {
	    	$state.go('listarRecetas')
	    };
	    
	  } ]);

var consultaRecetaController = recetarioApp.controller('ConsultaRecetaController', [
      'recetasData', '$scope', 'recetarioService', '$state',
      function(recetasData, $scope, recetarioService,recetasMasConsultadas){
    	  var recetas = recetasData.data.recetas;
          $scope.recetaSeleccionada = recetas[0];
          $scope.recetas = recetasData.data.recetas; 
    	  var recetasAptas = recetasData.data.recetasAptas;
    	  $scope.recetasAptas = recetasData.data.recetasAptas; 
          $scope.dificultadSelect = null;
          $scope.temporadaSelect = null;
          $scope.checkboxModel = false;
          $scope.aplicarFiltros = function(checkboxModel){
        	  if (!checkboxModel) {
        	      $scope.recetas = recetasData.data.recetas;
        	    }
        	    if (checkboxModel) {
        	      $scope.recetas = recetasData.data.recetasAptas;
        	    }
          };
//          $scope.consultas= recetasMasConsultadas.data.consultas;
            $scope.mostrarRecetas=false;
            $scope.detalleReceta=false
          
      }
      ])

//var redirectController = recetarioApp.controller('RedirectController', ['$state', function($state) {
//      $state.go('login');
//}]);
