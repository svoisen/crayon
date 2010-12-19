package org.voisen.crayon.view.model
{
	import flash.events.IEventDispatcher;
	
	import org.voisen.crayon.event.CrayonFileEvent;

	public class EditorViewModel
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		public function EditorViewModel()
		{
		}
		
		public function openFile():void
		{
			dispatcher.dispatchEvent( new CrayonFileEvent( CrayonFileEvent.SHOW_OPEN_FILE_DIALOG ) );
		}
	}
}