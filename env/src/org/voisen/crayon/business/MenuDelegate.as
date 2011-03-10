package org.voisen.crayon.business
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeWindow;
	import flash.display.Stage;
	
	import org.voisen.crayon.view.menu.ApplicationMenu;
	import org.voisen.crayon.view.menu.FileMenu;

	public class MenuDelegate
	{
		[Inject]
		public var fileMenu:FileMenu;
		
		public function setupMenus( stage:Stage ):void
		{
			if( NativeApplication.supportsMenu )
			{
				setupApplicationMenus();
			}
			
			if( NativeWindow.supportsMenu )
			{
				setupWindowMenus( stage );
			}
		}
		
		protected function setupApplicationMenus():void
		{
			var menu:NativeMenu = NativeApplication.nativeApplication.menu;
			
			//menu.getItemAt( 0 ).submenu = new ApplicationMenu();
			menu.getItemAt( 1 ).submenu = fileMenu;
		}
		
		protected function setupWindowMenus( stage:Stage ):void
		{
			var menu:NativeMenu = stage.nativeWindow.menu;
		}
	}
}