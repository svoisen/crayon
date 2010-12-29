package org.voisen.crayon.event
{
	import flash.events.Event;
	
	import org.voisen.crayon.view.component.IEditor;
	
	public class EditorEvent extends Event
	{
		public static const OPEN_FILE:String = "FileEvent.OPEN_FILE";
		
		public var editor:IEditor;
		
		public function EditorEvent( type:String )
		{
			super( type, true, true );
		}
	}
}