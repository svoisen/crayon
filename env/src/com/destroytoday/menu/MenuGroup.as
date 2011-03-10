package com.destroytoday.menu
{
	import flash.display.NativeMenuItem;
	
	import org.osflash.signals.Signal;

	public class MenuGroup implements IMenuGroup
	{
		//--------------------------------------------------------------------------
		//
		//  Signals
		//
		//--------------------------------------------------------------------------
		
		protected var _itemListChanged:Signal;
		
		protected var _visibleChanged:Signal;
		
		public function get itemListChanged():Signal
		{
			return _itemListChanged ||= new Signal();
		}
		
		public function set itemListChanged(value:Signal):void
		{
			_itemListChanged = value;
		}
		
		public function get visibleChanged():Signal
		{
			return _visibleChanged ||= new Signal();
		}
		
		public function set visibleChanged(value:Signal):void
		{
			_visibleChanged = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _itemList:Array;
		
		protected var _visible:Boolean = true;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function MenuGroup()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get itemList():Array
		{
			return _itemList ||= new Array();
		}
		
		public function set itemList(value:Array):void
		{
			if (value == _itemList) return;
			
			_itemList = value;
			
			itemListChanged.dispatch();
		}
		
		public function get numItems():int
		{
			return itemList.length;
		}
		
		public function get visible():Boolean
		{
			return _visible;
		}
		
		public function set visible(value:Boolean):void
		{
			if (value == _visible) return;
			
			_visible = value;
			
			visibleChanged.dispatch();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function addItem(item:NativeMenuItem):NativeMenuItem
		{
			if (itemList.indexOf(item) == -1)
			{
				itemList[itemList.length] = item;
				
				itemListChanged.dispatch();
			}
			
			return item;
		}
		
		public function removeItem(item:NativeMenuItem):NativeMenuItem
		{
			var index:int = itemList.indexOf(item);
			
			if (index != -1)
			{
				itemList.splice(index, 1);
				
				itemListChanged.dispatch();
			}
			
			return item;
		}
	}
}