package com.destroytoday.menu
{
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	
	public class Menu extends NativeMenu
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Menu()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function addSeparator():NativeMenuItem
		{
			return addItem(new MenuSeparator());
		}
		
		public function swapItems(currentItem:NativeMenuItem, newItem:NativeMenuItem):NativeMenuItem
		{
			var index:int = getItemIndex(currentItem);
			
			removeItem(currentItem);
			
			return addItemAt(newItem, index);
		}
	}
}