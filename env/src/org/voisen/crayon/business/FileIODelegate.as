package org.voisen.crayon.business
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	
	import mx.logging.ILogger;
	
	import org.osflash.signals.Signal;
	import org.voisen.crayon.util.LogUtil;

	public class FileIODelegate extends EventDispatcher
	{
		public const fileSelectedSignal:Signal = new Signal( File );
		
		private static const LOG:ILogger = LogUtil.getLogger( FileIODelegate );
		
		public function browseForFileToSave():void
		{
			try
			{
				var file:File = new File();
				file.addEventListener( Event.SELECT, handleFileSelection );
				file.browseForSave( "Save Crayon Sketch" );
			}
			catch( e:Error )
			{
				// TODO: Handle error
				LOG.error( e.message );
			}
		}
		
		public function browseForFileToOpen():void
		{
			try
			{
				var file:File = new File();
				file.addEventListener( Event.SELECT, handleFileSelection );
				file.browseForOpen( "Open Crayon Sketch", [new FileFilter( "Crayon source file", "*.crayon" )] );
			}
			catch( e:Error )
			{
				// TODO: Handle error
				LOG.error( e.message );
			}
		}
		
		public function saveToTempFile( text:String ):File
		{
			var tempFile:File;
			
			try
			{
				tempFile = File.createTempFile();
				var stream:FileStream = new FileStream();
				stream.open( tempFile, FileMode.WRITE );
				stream.writeUTFBytes( text );
				stream.close();
			}
			catch( e:Error )
			{
				LOG.error( e.message );
			}
			
			return tempFile;
		}
		
		public function readFileToString( file:File ):String
		{
			var text:String = new String();
			
			try
			{
				var stream:FileStream = new FileStream();
				stream.open( file, FileMode.READ );
				text = stream.readUTFBytes( stream.bytesAvailable );
				stream.close();
			}
			catch( e:Error )
			{
				// TODO: Handle error
				LOG.error( e.message );
			}
			
			return text;
		}
		
		public function saveFile( filePath:String, text:String ):void
		{
			try
			{
				var file:File = new File().resolvePath( filePath );
				var stream:FileStream = new FileStream();
				stream.open( file, FileMode.WRITE );
				stream.writeUTFBytes( text );
				stream.close();
			}
			catch( e:Error )
			{
				// TODO: Handle error
				LOG.error( e.message );
			}
		}
		
		protected function handleFileSelection( event:Event ):void
		{
			LOG.debug( "File selected: " + (event.target as File).nativePath );
			fileSelectedSignal.dispatch( event.target as File );
		}
	}
}