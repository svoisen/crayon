package org.voisen.crayon.controller
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	
	import mx.logging.ILogger;
	
	import org.voisen.crayon.business.FileIODelegate;
	import org.voisen.crayon.signal.EditorSignalBus;
	import org.voisen.crayon.util.LogUtil;
	import org.voisen.crayon.view.component.IEditor;
	import org.voisen.crayon.view.model.EditorViewModel;

	public class EditorController
	{
		[Inject]
		public var editorViewModel:EditorViewModel;
		
		[Inject]
		public var fileDelegate:FileIODelegate;
		
		[Inject]
		public var signalBus:EditorSignalBus;
		
		private static const LOG:ILogger = LogUtil.getLogger( EditorController );
		
		[PostConstruct]
		public function setupSignalBus():void
		{
			signalBus.openFileSignal.add( openFile );
			signalBus.saveFileSignal.add( saveFile );
			signalBus.showInConsoleSignal.add( showInConsole );
			signalBus.createSketchSignal.add( createSketch );
		}
		
		[PreDestroy]
		public function clearSignalBus():void
		{
			signalBus.openFileSignal.remove( openFile );
			signalBus.saveFileSignal.remove( saveFile );
			signalBus.showInConsoleSignal.remove( showInConsole );
			signalBus.createSketchSignal.remove( createSketch );
		}
		
		public function openFile( editor:IEditor ):void
		{	
			LOG.debug( "openFile" );
			
			var selectHandler:Function = 
				function( file:File ):void
				{
					editor.initializeBuffer( file.nativePath, fileDelegate.readFileToString( file ) );
					fileDelegate.fileSelectedSignal.removeAll();
				};
			
			fileDelegate.fileSelectedSignal.add( selectHandler );
			fileDelegate.browseForFileToOpen();
		}
		
		public function saveFile( editor:IEditor ):void
		{
			LOG.debug( "saveFile" );
			
			if( editor.newBuffer )
			{
				LOG.debug( "New buffer; prompting for filename" );
				var selectHandler:Function =
					function( file:File ):void
					{
						fileDelegate.saveFile( file.nativePath, editor.buffer );
						fileDelegate.fileSelectedSignal.removeAll();
					};
				fileDelegate.fileSelectedSignal.add( selectHandler );
				fileDelegate.browseForFileToSave();
			}
			else
			{
				fileDelegate.saveFile( editor.filePath, editor.buffer );
				editor.markAsSaved();
			}
		}
		
		public function showInConsole( text:String ):void
		{
			LOG.debug( "showCompilerError" );
			
			editorViewModel.showConsole();
			editorViewModel.consoleText = text;
		}
		
		public function createSketch():void
		{
			LOG.debug( "createSketch" );
		}
	}
}