package org.voisen.crayon.event
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class SketchEvent extends Event
	{
		public static const RUN_SKETCH:String = "SketchEvent.RUN_SKETCH";
		
		public var sketch:String;
		
		public function SketchEvent( type:String )
		{
			super( type, true, true );
		}
	}
}