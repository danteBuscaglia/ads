package queComemosInterface

import dds.grupo9.queComemos.Receta
import org.uqbar.arena.widgets.Panel
import dds.grupo9.queComemos.Persona
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.windows.Dialog
import dds.grupo9.queComemos.applicationModels.SeleccionRecetasAppModel
import java.awt.Color
import java.util.Collection
import dds.grupo9.queComemos.monitoreoDeConsultas.RecetasMasConsultadas
import scala.xml.dtd.ContentModel.ElemName

class SeleccionRecetas extends SimpleWindow <SeleccionRecetasAppModel> {
	
	new(WindowOwner owner, Persona persona, RecetasMasConsultadas monitor) {
     	super(owner, new SeleccionRecetasAppModel(persona, monitor))
 	}
 
 	
 	
 	override def createMainTemplate(Panel mainPanel) {
		title = "Recetas"
		taskDescription = "Elija la receta que desea ver en detalle"
		
		super.createMainTemplate(mainPanel)
		
	}
 
 	override createFormPanel(Panel mainPanel) {
	  	this.title = "Bienvenido a ¿Qué comemos?"
  		new Label(mainPanel).bindValueToProperty("mensajeCorrespondiente") 
  		val table = new Table<Receta>(mainPanel, typeof(Receta)) => [
	   		bindItemsToProperty("seleccionDeRecetas") 
   			bindValueToProperty("recetaSeleccionada")
  		]
  		this.describeResultsGrid(table)
 
  	}
  	
  	override addActions(Panel mainPanel) {	
  		
  		val actionsPanel = new Panel(mainPanel).layout = new HorizontalLayout
		val elementSelected = new NotNullObservable("recetaSeleccionada")
		new Button(actionsPanel) => [
			caption = "Ver"
			onClick [ |
				this.verReceta	
			]
			bindEnabled(elementSelected) 
		]
	}
 
	def describeResultsGrid(Table <Receta> table) {
  		
  		new Column<Receta>(table) => [
	        title = "Nombre"
    		fixedSize = 150
        	bindContentsToProperty("nombre")
        	bindBackground("nombreDuenio").transformer = 
        		[String nombre | 
        			if (nombre.equals("D10S (Receta Publica)")) {
        				Color.BLUE 
        			}
        			else {
        				if (nombre.equals(modelObject.persona.nombre)) {
        					Color.ORANGE 
        					}	
        				else {
        					Color.GREEN
        					}
        			}
        		]
  		]
  
  		new Column<Receta>(table) => [
    		title = "Calorías"
        	fixedSize = 150
        	bindContentsToProperty("calorias")
  		]
  
  		new Column<Receta>(table) => [
	        title = "Dificultad"
    	    fixedSize = 150
        	bindContentsToProperty("dificultad")
  		]
  
  		new Column<Receta>(table) => [
        	title = "Temporada"
	        fixedSize = 150
    	    bindContentsToProperty("temporadasCorrespondientes")
  		]
  		
  		
	}
	
		
	def void verReceta() {
		this.openDialog(new DetalleReceta(this, modelObject.recetaSeleccionada, modelObject.persona))
	}
	
	def openDialog(Dialog<?> dialog) {
		//dialog.onAccept[|modelObject.getReceta]
		dialog.open
	}
}