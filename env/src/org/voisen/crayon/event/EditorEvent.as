package org.voisen.crayon.event
{
	import flash.events.Event;
	
	import org.voisen.crayon.view.component.IEditor;
	
	public class EditorEvent extends Event
	{
		public static const OPEN_FILE:String = "EditorEvent.OPEN_FILE";
		public static const SAVE_FILE:String = "EditorEvent.SAVE_FILE";
		
		public var editor:IEditor;
		
		public function EditorEvent( type:String )
		{
			super( type, true, true );
		}
	}
}