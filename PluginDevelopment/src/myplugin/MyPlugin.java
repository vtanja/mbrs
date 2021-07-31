package myplugin;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;

import javax.swing.JOptionPane;

import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;


import com.nomagic.actions.NMAction;
import com.nomagic.magicdraw.actions.ActionsConfiguratorsManager;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.StaxDriver;

/** MagicDraw plugin that performes code generation */
public class MyPlugin extends com.nomagic.magicdraw.plugins.Plugin {
	
	String pluginDir = null; 
	
	public void init() {
		
		pluginDir = getDescriptor().getPluginDirectory().getPath();
		
		// Creating submenu in the MagicDraw main menu 	
		ActionsConfiguratorsManager manager = ActionsConfiguratorsManager.getInstance();		
		manager.addMainMenuConfigurator(new MainMenuConfigurator(getSubmenuActions()));
		
		try {
			ProjectOptions projectOptions = ProjectOptions.fromXML(pluginDir , "ProjectOptions.xml");
			
			ProjectOptions.getProjectOptions().setGeneratorOptions(projectOptions.getGeneratorOptions());
		}
		catch(FileNotFoundException fe){
			JOptionPane.showMessageDialog(null, "Loading project options failed.");
		}
		catch(Exception e) {
			JOptionPane.showMessageDialog(null, e.getLocalizedMessage());
		}
		
	}

	private NMAction[] getSubmenuActions()
	{
	   return new NMAction[]{
			new GenerateAction("Generate"),
	   };
	}
	
	public boolean close() {
		return true;
	}
	
	public boolean isSupported() {				
		return true;
	}
}


