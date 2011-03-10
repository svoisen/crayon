package org.voisen.crayon.view.menu
{
	import com.destroytoday.menu.IMenuGroup;
	import com.destroytoday.menu.MenuGroup;
	import com.destroytoday.menu.MenuItem;
	import com.destroytoday.menu.SeparatedMenu;
	
	import flash.ui.Keyboard;
	
	public class ApplicationMenu extends SeparatedMenu
	{
		public var preferencesGroup:IMenuGroup;
		
		public var preferencesItem:MenuItem;
		
		public function ApplicationMenu()
		{
			preferencesGroup = addGroup( new MenuGroup() );
			
			preferencesItem = preferencesGroup.addItem( new MenuItem( "Preferences", [Keyboard.COMMAND], "," ) ) as MenuItem;
		}
	}
}