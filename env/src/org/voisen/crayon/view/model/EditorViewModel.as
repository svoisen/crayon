package org.voisen.crayon.view.model
{
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	import org.voisen.crayon.model.ApplicationModel;
	import org.voisen.crayon.view.component.IEditor;

	public class EditorViewModel
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var model:ApplicationModel;
		
		protected var _currentState:String;
		
		protected var _consoleText:String;
		
		protected var _selectedEditor:IEditor;
		
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

		[Bindable]
		public function get selectedEditor():IEditor
		{
			return _selectedEditor;
		}

		public function set selectedEditor(value:IEditor):void
		{
			_selectedEditor = value;
			
			model.currentEditor = value;
		}

	}
}