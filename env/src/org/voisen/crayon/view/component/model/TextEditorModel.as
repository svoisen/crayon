package org.voisen.crayon.view.component.model
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	import org.voisen.crayon.view.component.TextEditor;
	import org.voisen.crayon.view.component.event.TextEditorEvent;

	public class TextEditorModel extends EventDispatcher
	{
		protected var view:TextEditor;
		
		protected var _filePath:String;
		
		protected var dirtyFlag:Boolean;
		
		protected var _newBufferFlag:Boolean;
		
		public function TextEditorModel( view:TextEditor )
		{
			this.view = view;
			
			dirtyFlag = false;
			
			_newBufferFlag = true;
			
			filePath = File.documentsDirectory.resolvePath( "untitled.crayon" ).nativePath;
		}
		
		public function update():void
		{
			dirtyFlag = true;
			
			dispatchEvent( new Event( "lineCountChanged" ) );
			dispatchEvent( new Event( "verticalScrollPositionChanged" ) );
			dispatchEvent( new Event( "fileNameChanged" ) );
		}
		
		[Bindable("verticalScrollPositionChanged")]
		public function get verticalScrollPosition():int
		{
			return view.editor.scroller.verticalScrollBar.value;
		}
		
		[Bindable("lineCountChanged")]
		public function get lineCount():uint
		{
			var buffer:String = view.editor.text;
			var index:int = buffer.indexOf( "\n", 0 );
			var count:uint = 0;
			
			while( index > -1 )
			{
				index = buffer.indexOf( "\n", index + 1 );
				count++;
			}
			
			return count + 1;
		}

		[Bindable]
		public function get filePath():String
		{
			return _filePath;
		}

		public function set filePath( value:String ):void
		{
			_filePath = value;
			dispatchEvent( new Event( "fileNameChanged" ) );
		}
		
		[Bindable("fileNameChanged")]
		public function get fileName():String
		{
			return new File().resolvePath( filePath ).name + (dirtyFlag ? " *" : "");
		}
		
		public function get newBuffer():Boolean
		{
			return _newBufferFlag;
		}
		
		public function set newBuffer( value:Boolean ):void
		{
			_newBufferFlag = value;
		}
	}
}