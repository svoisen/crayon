package com.destroytoday.menu
{
	import flash.display.NativeMenuItem;
	
	import org.osflash.signals.Signal;

	public interface IMenuGroup
	{
		function get itemListChanged():Signal;
		function get visibleChanged():Signal;
		
		function get itemList():Array;
		function set itemList(value:Array):void;
		
		function get numItems():int;
		function get visible():Boolean;
		function set visible(value:Boolean):void;
		
		function addItem(item:NativeMenuItem):NativeMenuItem;
		function removeItem(item:NativeMenuItem):NativeMenuItem;
	}
}