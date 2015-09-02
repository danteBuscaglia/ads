package queComemosInterface

import dds.grupo9.queComemos.Ingrediente
import dds.grupo9.queComemos.Receta
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import dds.grupo9.queComemos.Persona
import dds.grupo9.queComemos.applicationModels.DetalleRecetaAppModel

class DetalleReceta extends Dialog<DetalleRecetaAppModel>{
	
	new(WindowOwner parent, Receta recetaModelo, Persona logueado) {
		 super(parent, new DetalleRecetaAppModel(logueado, recetaModelo))
	}
	
	
	override createContents(Panel mainPanel) {
		this.title = "Detalle Receta"
		
		construirEncabezado(mainPanel)
		
      	super.createMainTemplate(mainPanel)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		val secondaryPanel = new Panel(mainPanel)
		secondaryPanel.layout = new ColumnLayout(2) // Seteo nuevo panel en el cuerpo de la ventana con dos columnas
		contruirMitadIzquierda(secondaryPanel)
		construirMitadDerecha(secondaryPanel)
      	construirPie(mainPanel)
	}
	
	def construirPie(Panel mainPanel) {      	
      	/*Abajo*/
		new Label(mainPanel).text = "Proceso de preparación"
		      	new Label(mainPanel).bindValueToProperty("recetaSeleccionada.explicacion")
		      	val secondaryPanel4 = new Panel(mainPanel)
		      	secondaryPanel4.layout = new ColumnLayout(5)
		      	val subPanel1 = new Panel(secondaryPanel4)
		      	val subPanel2 = new Panel(secondaryPanel4)
		      	val subPanel3 = new Panel(secondaryPanel4)// SI FUNCIONARA EL ANCHO DEL BOTON ESTO SE PUEDE EVITAR
		      	new Button(subPanel3) => [
				caption = "Volver"
				onClick [ | 
					this.close()
				]
				//width = 60
				]
	}
	
	def construirMitadDerecha(Panel secondaryPanel) {
		/*Derecha*/
		val panelDerecho = new Panel(secondaryPanel)
		new Label(panelDerecho).text = "Temporada"
		new Label(panelDerecho).bindValueToProperty("recetaSeleccionada.temporadasCorrespondientes") //Deberia ser solo .head pero rompe
		
		     	new Label(panelDerecho).text = "Condimentos"
		     	new List(panelDerecho) => [
		           	bindItemsToProperty("recetaSeleccionada.condimentos")
		            width = 200
		            height = 100
		      	]
		      	
		      	new Label(panelDerecho).text = "Condiciones preexistentes"
		      	new List(panelDerecho) => [
		           	bindItemsToProperty("recetaSeleccionada.condiciones")
		            width = 200
		            height = 100
		      	]
	}
	
	def contruirMitadIzquierda(Panel secondaryPanel) {
		/*Izquierda*/
		val panelIzquierdo = new Panel(secondaryPanel)
		new Label(panelIzquierdo).text = "Dificultad"
		new Label(panelIzquierdo).bindValueToProperty("recetaSeleccionada.dificultad")
		
		new Label(panelIzquierdo).text = "Ingredientes"
		
		val table = new Table<Ingrediente>(panelIzquierdo, typeof(Ingrediente)) => [
			bindItemsToProperty("recetaSeleccionada.ingredientes")
		]
		this.describeResultsGrid(table)
		
		val secondaryPanel3 = new Panel(panelIzquierdo)
		secondaryPanel3.layout = new ColumnLayout(2)
		val subPanelIzquierdo = new Panel(secondaryPanel3)
		val subPanelDerecho = new Panel(secondaryPanel3)
//		if(modelObject.logueado.recetasFavoritas.contains(modelObject.recetaSeleccionada)){
//			???
//		}
		new CheckBox(subPanelIzquierdo).bindValueToProperty("esFavorita")
		new Label(subPanelDerecho).text = "Favorita"
	}
	
	def describeResultsGrid(Table<Ingrediente> table) {
		new Column<Ingrediente>(table) => [
		      	title = "Cantidad"
		     	fixedSize = 150
		      	bindContentsToProperty("cantidad")
		]
		
		new Column<Ingrediente>(table) => [
		      	title = "Ingrediente"
		     	fixedSize = 150
		      	bindContentsToProperty("nombre")
		]
	}
	
	def construirEncabezado(Panel mainPanel) {
		new Label(mainPanel).bindValueToProperty("recetaSeleccionada.nombre")
		val secondaryPanel = new Panel(mainPanel)
		secondaryPanel.layout = new HorizontalLayout
		new Label(secondaryPanel).bindValueToProperty("recetaSeleccionada.calorias")
		new Label(secondaryPanel).text = "calorias "
		new Label(secondaryPanel).text = "Creada por: "
		new Label(secondaryPanel).bindValueToProperty("autor")
	}
	
}