package org.voisen.crayon.view.model
{
	import flash.events.IEventDispatcher;
	
	import org.voisen.crayon.event.EditorEvent;
	import org.voisen.crayon.view.component.IEditor;

	public class EditorViewModel
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		public function EditorViewModel()
		{
		}
		
		public function openFile( editor:IEditor ):void
		{
			var event:EditorEvent = new EditorEvent( EditorEvent.OPEN_FILE );
			event.editor = editor;
			
			dispatcher.dispatchEvent( event );
		}
	}
}