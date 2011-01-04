package org.voisen.crayon.event
{
	import flash.events.Event;
	
	public class ConsoleEvent extends Event
	{
		public static const SHOW_TEXT:String = "ConsoleEvent.SHOW_TEXT";
		
		public var text:String;
		
		public function ConsoleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}