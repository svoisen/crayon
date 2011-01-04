package org.voisen.crayon.controller
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	
	import mx.logging.ILogger;
	
	import org.voisen.crayon.business.FileIODelegate;
	import org.voisen.crayon.event.FileIOEvent;
	import org.voisen.crayon.util.LogUtil;
	import org.voisen.crayon.view.component.IEditor;
	import org.voisen.crayon.view.model.EditorViewModel;

	public class EditorController
	{
		private static const LOG:ILogger = LogUtil.getLogger( EditorController );
		
		[Inject]
		public var editorViewModel:EditorViewModel;
		
		[EventHandler( event="EditorEvent.OPEN_FILE", properties="editor" )]
		public function openFile( editor:IEditor ):void
		{	
			LOG.debug( "openFile" );
			
			var delegate:FileIODelegate = new FileIODelegate();
			var selectHandler:Function = 
				function( event:FileIOEvent ):void
				{
					editor.initializeBuffer( event.file.nativePath, delegate.readFileToString( event.file ) );
				};
			
			delegate.addEventListener( FileIOEvent.FILE_SELECTED, selectHandler );
			delegate.browseForFileToOpen();
		}
		
		[EventHandler( event="EditorEvent.SAVE_FILE", properties="editor" )]
		public function saveFile( editor:IEditor ):void
		{
			LOG.debug( "saveFile" );
			
			var delegate:FileIODelegate = new FileIODelegate();
			
			if( editor.newBuffer )
			{
				LOG.debug( "New buffer; prompting for filename" );
				var selectHandler:Function =
					function( event:FileIOEvent ):void
					{
						delegate.saveFile( event.file.nativePath, editor.buffer );
					};
				delegate.addEventListener( FileIOEvent.FILE_SELECTED, selectHandler );
				delegate.browseForFileToSave();
			}
			else
			{
				delegate.saveFile( editor.filePath, editor.buffer );
			}
		}
		
		[EventHandler( event="ConsoleEvent.SHOW_TEXT", properties="text" )]
		public function showInConsole( text:String ):void
		{
			LOG.debug( "showCompilerError" );
			
			editorViewModel.showConsole();
			editorViewModel.consoleText = text;
		}
	}
}