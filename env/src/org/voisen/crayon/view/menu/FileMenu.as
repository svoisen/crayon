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
		
		protected var createGroup:IMenuGroup;
		protected var saveGroup:IMenuGroup;
		protected var closeGroup:IMenuGroup;
		protected var runGroup:IMenuGroup;
		
		protected var newSketchItem:MenuItem;
		protected var openSketchItem:MenuItem;
		protected var closeSketchItem:MenuItem;
		protected var saveSketchItem:MenuItem;
		protected var saveSketchAsItem:MenuItem;
		protected var runSketchItem:MenuItem;
		
		public function FileMenu()
		{
			model = new FileMenuModel();
			
			createGroup = addGroup( new MenuGroup() );
			closeGroup = addGroup( new MenuGroup() );
			saveGroup = addGroup( new MenuGroup() );
			runGroup = addGroup( new MenuGroup() );
			
			newSketchItem = createGroup.addItem( new MenuItem( "New Sketch", [Keyboard.COMMAND], "n" ) ) as MenuItem;
			openSketchItem = createGroup.addItem( new MenuItem( "Open Sketch...", [Keyboard.COMMAND], "o" ) ) as MenuItem;
			
			closeSketchItem = closeGroup.addItem( new MenuItem( "Close Sketch", [Keyboard.COMMAND], "w" ) ) as MenuItem;
			
			saveSketchItem = saveGroup.addItem( new MenuItem( "Save", [Keyboard.COMMAND], "s" ) ) as MenuItem;
			saveSketchAsItem = saveGroup.addItem( new MenuItem( "Save As..." ) ) as MenuItem;
			
			runSketchItem = runGroup.addItem( new MenuItem( "Run", [Keyboard.COMMAND], "\n" ) ) as MenuItem;
			
			newSketchItem.addEventListener( Event.SELECT, function( event:Event ):void{ model.createSketch(); } );
			openSketchItem.addEventListener( Event.SELECT, function( event:Event ):void{ model.openSketch(); } );
			saveSketchItem.addEventListener( Event.SELECT, function( event:Event ):void{ model.saveSketch(); } );
			runSketchItem.addEventListener( Event.SELECT, function( event:Event ):void{ model.runSketch(); } );
		}
	}
}