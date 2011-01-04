package org.voisen.crayon.event
{
	import flash.display.Stage;
	import flash.events.Event;
	
	public class InitializationEvent extends Event
	{
		public static const APP_INIT:String = "InitializationEvent.APP_INIT";
		
		public var stage:Stage;
		
		public function InitializationEvent( type:String, stage:Stage )
		{
			super(type, true, true);
			this.stage = stage;
		}
	}
}