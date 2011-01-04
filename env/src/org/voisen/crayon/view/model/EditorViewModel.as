package org.voisen.crayon.view.model
{
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	import org.voisen.crayon.event.EditorEvent;
	import org.voisen.crayon.event.SketchEvent;
	import org.voisen.crayon.view.component.IEditor;

	public class EditorViewModel
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		protected var _currentState:String;
		
		protected var _consoleText:String;
		
		public function EditorViewModel()
		{
			_currentState = "";
		}
		
		public function showConsole():void
		{
			currentState = "showConsole";
		}
		
		public function hideConsole():void
		{
			currentState = "";
		}
		
		public function openFile( editor:IEditor ):void
		{
			var event:EditorEvent = new EditorEvent( EditorEvent.OPEN_FILE );
			event.editor = editor;
			
			dispatcher.dispatchEvent( event );
		}
		
		public function saveFile( editor:IEditor ):void
		{
			var event:EditorEvent = new EditorEvent( EditorEvent.SAVE_FILE );
			event.editor = editor;
			
			dispatcher.dispatchEvent( event );
		}
		
		public function runFile( editor:IEditor ):void
		{
			var event:SketchEvent = new SketchEvent( SketchEvent.RUN_SKETCH );
			event.sketch = editor.buffer;
			
			dispatcher.dispatchEvent( event );
		}

		[Bindable]
		public function get currentState():String
		{
			return _currentState;
		}

		public function set currentState(value:String):void
		{
			_currentState = value;
		}

		[Bindable]
		public function get consoleText():String
		{
			return _consoleText;
		}

		public function set consoleText(value:String):void
		{
			_consoleText = value;
		}
	}
}