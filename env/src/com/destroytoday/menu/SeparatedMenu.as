package com.destroytoday.menu
{
	import org.osflash.signals.Signal;

	public class SeparatedMenu extends Menu
	{
		//--------------------------------------------------------------------------
		//
		//  Signals
		//
		//--------------------------------------------------------------------------
		
		protected var _groupListChanged:Signal;
		
		public function get groupListChanged():Signal
		{
			return _groupListChanged ||= new Signal();
		}
		
		public function set groupListChanged(value:Signal):void
		{
			_groupListChanged = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		protected var _groupList:Array;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function SeparatedMenu()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getters / Setters
		//
		//--------------------------------------------------------------------------
		
		public function get groupList():Array
		{
			return _groupList ||= new Array();
		}
		
		public function set groupList(value:Array):void
		{
			if (value == _groupList) return;
			
			_groupList = value;
			
			updateItems();
			groupListChanged.dispatch();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function updateItems():void
		{
			var itemList:Array = [];
			
			for each (var group:IMenuGroup in groupList)
			{
				var visible:Boolean = (group.visible && group.itemList.length > 0);
				
				if (visible && itemList.length > 0)
				{
					itemList = itemList.concat(new MenuSeparator(), group.itemList);
				}
				else if (visible)
				{
					itemList = itemList.concat(group.itemList);
				}
			}

			items = itemList;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function addGroup(group:IMenuGroup):IMenuGroup
		{
			if (groupList.indexOf(group) == -1)
			{
				groupList[groupList.length] = group;
				
				group.itemListChanged.add(groupItemListChangedHandler);
				group.visibleChanged.add(groupVisibleChangedHandler);

				updateItems();
				groupListChanged.dispatch();
			}
			
			return group;
		}
		
		public function removeGroup(group:IMenuGroup):IMenuGroup
		{
			var index:int = groupList.indexOf(group);
			
			if (index != -1)
			{
				groupList.splice(index, 1);
				
				group.itemListChanged.remove(groupItemListChangedHandler);
				group.visibleChanged.remove(groupVisibleChangedHandler);
				
				updateItems();
				groupListChanged.dispatch();
			}
			
			return group;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Handlers
		//
		//--------------------------------------------------------------------------
		
		protected function groupItemListChangedHandler():void
		{
			updateItems();
		}
		
		protected function groupVisibleChangedHandler():void
		{
			updateItems();
		}
	}
}