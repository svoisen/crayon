package org.voisen.crayon.view.component.event
{
	import flash.events.Event;
	
	public class TextEditorEvent extends Event
	{
		public static const OPEN_FILE_CLICK:String = "openFileClick";
		
		public function TextEditorEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}