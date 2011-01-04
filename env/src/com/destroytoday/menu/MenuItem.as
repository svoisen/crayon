package com.destroytoday.menu
{
	import flash.display.NativeMenuItem;
	
	public class MenuItem extends NativeMenuItem
	{
		public function MenuItem(label:String, keyEquivalentModifiers:Array = null, keyEquivalent:String = null)
		{
			super(label, false);
			
			this.keyEquivalentModifiers = keyEquivalentModifiers;
			this.keyEquivalent = keyEquivalent;
		}
	}
}