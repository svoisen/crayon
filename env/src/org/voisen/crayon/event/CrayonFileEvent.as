package org.voisen.crayon.event
{
	import flash.events.Event;
	
	public class CrayonFileEvent extends Event
	{
		public static const SHOW_OPEN_FILE_DIALOG:String = "FileEvent.SHOW_OPEN_FILE_DIALOG";
		
		public function CrayonFileEvent( type:String )
		{
			super( type, true, true );
		}
	}
}