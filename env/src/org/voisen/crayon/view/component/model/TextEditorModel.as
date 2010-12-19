package org.voisen.crayon.view.component.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.voisen.crayon.view.component.TextEditor;
	import org.voisen.crayon.view.component.event.TextEditorEvent;

	public class TextEditorModel extends EventDispatcher
	{
		protected var view:TextEditor;
		
		public function TextEditorModel( view:TextEditor )
		{
			this.view = view;
		}
		
		public function openFile():void
		{
			view.dispatchEvent( new TextEditorEvent( TextEditorEvent.OPEN_FILE_CLICK ) );
		}
	}
}