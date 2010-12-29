package org.voisen.crayon.controller
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	
	import org.voisen.crayon.view.component.IEditor;

	public class EditorController
	{
		[EventHandler( event="EditorEvent.OPEN_FILE", properties="editor" )]
		public function openFile( editor:IEditor ):void
		{	
			try
			{
				var file:File = new File();
				var openHandler:Function = 
					function( event:Event ):void
					{
						var stream:FileStream = new FileStream();
						stream.open( event.target as File, FileMode.READ );
						editor.buffer = stream.readUTFBytes( stream.bytesAvailable );
					};
				file.addEventListener( Event.SELECT, openHandler );
				
				file.browseForOpen( "Open Crayon Sketch", [new FileFilter( "Crayon source file", "*.crayon" )] );
			}
			catch( e:Error )
			{
				// TODO: Handle error
				trace( e.message );
			}
		}
		
		public function saveFile( text:String ):void
		{
			
		}
	}
}