package org.voisen.crayon.controller
{
	import flash.filesystem.File;
	import flash.net.FileFilter;

	public class EditorController
	{
		[EventHandler( event="CrayonFileEvent.SHOW_OPEN_FILE_DIALOG" )]
		public function showOpenFileDialog():void
		{
			new File().browseForOpen( "Open Crayon Sketch", [new FileFilter( "Crayon source file", "*.crayon" )] );
		}
		
		public function openFile():void
		{
			
		}
		
		public function saveFile( text:String ):void
		{
			
		}
	}
}