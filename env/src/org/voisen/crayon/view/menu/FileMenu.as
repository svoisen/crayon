package org.voisen.crayon.view.menu
{
	import com.destroytoday.menu.IMenuGroup;
	import com.destroytoday.menu.MenuGroup;
	import com.destroytoday.menu.MenuItem;
	import com.destroytoday.menu.SeparatedMenu;
	
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	import org.voisen.crayon.view.menu.model.FileMenuModel;
	
	public class FileMenu extends SeparatedMenu
	{
		[Inject]
		public var model:FileMenuModel;
		
		public var createGroup:IMenuGroup;
		public var saveGroup:IMenuGroup;
		
		public var newSketchItem:MenuItem;
		public var openSketchItem:MenuItem;
		public var saveSketchItem:MenuItem;
		public var saveSketchAsItem:MenuItem;
		
		public function FileMenu()
		{
			createGroup = addGroup( new MenuGroup() );
			saveGroup = addGroup( new MenuGroup() );
			
			newSketchItem = createGroup.addItem( new MenuItem( "New", [Keyboard.COMMAND], "n") ) as MenuItem;
			openSketchItem = createGroup.addItem( new MenuItem( "Open...", [Keyboard.COMMAND], "o") ) as MenuItem;
			
			saveSketchItem = saveGroup.addItem( new MenuItem( "Save", [Keyboard.COMMAND], "s") ) as MenuItem;
			saveSketchAsItem = saveGroup.addItem( new MenuItem( "Save As..." ) ) as MenuItem;
			
			newSketchItem.addEventListener( Event.SELECT, function( event:Event ):void{ model.createSketch(); } );
		}
	}
}