package org.voisen.crayon.event
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class FileIOEvent extends Event
	{
		public static const FILE_SELECTED:String = "FileIODelegateEvent.FILE_SELECTED";
		public static const FILE_OPENED:String = "FileIODelegateEvent.FILE_OPENED";
		
		public var file:File;
		
		public function FileIOEvent( type:String )
		{
			super(type, true, true);
		}
	}
}