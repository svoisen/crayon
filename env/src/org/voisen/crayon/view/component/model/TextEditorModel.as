package org.voisen.crayon.view.component.model
{
	import flash.events.Event;
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
		
		public function update():void
		{
			dispatchEvent( new Event( "lineCountChanged" ) );
			dispatchEvent( new Event( "verticalScrollPositionChanged" ) );
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
	}
}