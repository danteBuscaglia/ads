package dds.grupo9.queComemos.controller

import org.uqbar.commons.model.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import dds.grupo9.queComemos.xtrest.JSONPropertyUtils
import dds.grupo9.queComemos.repoUsuarios.RepoUsuarioEjemplo
import dds.grupo9.queComemos.repoRecetas.RepoRecetasEjemplo
import dds.grupo9.queComemos.applicationModels.LogueoAppModel
import dds.grupo9.queComemos.applicationModels.SeleccionRecetasAppModel
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.controller.PedidoLogin
import org.uqbar.xtrest.api.annotation.Post

import static dds.grupo9.queComemos.controller.ConfiguredDependencies.*
import javax.servlet.http.HttpServletRequest
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.applicationModels.DetalleRecetaAppModel
import dds.grupo9.queComemos.RecetaSimple
import java.util.Collection

@Controller
class RecetarioController {

	extension JSONUtils = new JSONUtils
//	extension JSONPropertyUtils = new JSONPropertyUtils

	@Post("/login")
	def Result login(@Body String body) {
		//println(body)
		var PedidoLogin pedido = body.fromJson(PedidoLogin)
		var LogueoAppModel logueo = new LogueoAppModel();
		logueo.persona.nombre = pedido.nombre
		logueo.contrasegna = "unaContrasegna"
		var Persona p = logueo.personaBuscada()
		response.contentType = ContentType.APPLICATION_JSON
		ok(new RespuestaLogin(p).toJson)
	}	

	@Get("/recetas")
	def Result recetas() {
		var Persona persona = obtenerUsuario(request)
		println(persona.nombre)
		var seleccionador = new SeleccionRecetasAppModel(persona, new RecetasMasConsultadas)
		var Collection<Receta> recetas = repoRecetas.getRecetas
		var Collection<Receta> recetasPosta = seleccionador.seleccionDeRecetas
		println(recetas)
		println(recetas.head.nombre)
		println(recetasPosta)
		println(recetasPosta.head.nombre)
		println(recetasPosta.get(1).nombre)
		println(recetasPosta.get(2).nombre)
		response.contentType = ContentType.APPLICATION_JSON
		ok(new ListadoRecetas(persona, recetas).toJson)
	}
	
	def obtenerUsuario(HttpServletRequest request) {
		var Persona personaBuscada = new Persona
		personaBuscada.nombre = getCookie(request, "usuario")
		repoUsuarios.get(personaBuscada)
	}
	
	def getCookie(HttpServletRequest request, String string) {
		request.cookies.findFirst[it.name == string].value	
	}
	
	@Post("/detalleReceta")
	def Result detalleReceta(@Body String body) {
		println(body)
		var RecetaSimple receta = body.fromJson(RecetaSimple)
//		var Receta receta = this.adaptarJson(body)
		println(receta) 
		var Persona persona = obtenerUsuario(request)
		println(persona)
		//var DetalleRecetaAppModel detalleReceta = new DetalleRecetaAppModel(persona, receta)
		ok	
	}
	
	@Get("/recetaActual")
	def Result recetaActual(@Body String body) {
		var Receta recetaBuscada = body.fromJson(Receta)
		var Persona persona = obtenerUsuario(request)
		response.contentType = ContentType.APPLICATION_JSON
		ok(new RecetaActual(persona, recetaBuscada).toJson)
	}
	
	def static void main(String[] args) {
		XTRest.start(RecetarioController, 8090)
	}

}
