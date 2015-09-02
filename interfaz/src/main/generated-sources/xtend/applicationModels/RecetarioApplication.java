package applicationModels;

import org.uqbar.arena.Application;
import org.uqbar.arena.windows.Window;
import queComemosInterface.LogueoWindow;

@SuppressWarnings("all")
public class RecetarioApplication extends Application {
  public static void main(final String[] args) {
    RecetarioApplication _recetarioApplication = new RecetarioApplication();
    _recetarioApplication.start();
  }
  
  public Window<?> createMainWindow() {
    return new LogueoWindow(this);
  }
}
