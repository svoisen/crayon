package org.voisen.crayon.business
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	
	import mx.logging.ILogger;
	
	import org.voisen.crayon.event.CompilerEvent;
	import org.voisen.crayon.util.LogUtil;

	public class CompilerDelegate extends EventDispatcher
	{
		protected static const CRAYONC:String = "/Users/svoisen/Projects/Personal/crayon/bin/crayonc";
		
		private static const LOG:ILogger = LogUtil.getLogger( CompilerDelegate );
		
		/**
		 * Set to true when the compiler encounters an error.
		 */
		protected var errorFlag:Boolean;
		
		public function compile( sourceFile:File ):void
		{
			LOG.debug( "compile" );
			
			if( !NativeProcess.isSupported )
			{
				LOG.error( "NativeProcess is not supported" );
				return;
			}
			
			var processInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			var args:Vector.<String> = new Vector.<String>();
			args.push( sourceFile.nativePath );
			processInfo.executable = new File().resolvePath( CRAYONC );
			processInfo.arguments = args;
			
			var process:NativeProcess = new NativeProcess();
			process.addEventListener( ProgressEvent.STANDARD_OUTPUT_DATA, handleStandardOutput );
			process.addEventListener( ProgressEvent.STANDARD_ERROR_DATA, handleStandardError );
			process.addEventListener( IOErrorEvent.STANDARD_ERROR_IO_ERROR, handleIOError );
			process.addEventListener( IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, handleIOError );
			process.addEventListener( NativeProcessExitEvent.EXIT, handleProcessExit );
			
			process.start( processInfo );
		}
		
		protected function handleStandardOutput( event:ProgressEvent ):void
		{
			LOG.debug( "handleStandardOutput" );
			
			var process:NativeProcess = event.target as NativeProcess;
			var output:String = process.standardOutput.readUTFBytes( process.standardOutput.bytesAvailable );
			
			LOG.info( output );
		}
		
		protected function handleStandardError( event:ProgressEvent ):void
		{
			LOG.debug( "handleStandardError" );
			
			errorFlag = true;
			
			var process:NativeProcess = event.target as NativeProcess;
			var output:String = process.standardError.readUTFBytes( process.standardError.bytesAvailable )
			
			LOG.error( output );
			
			var compilerEvent:CompilerEvent = new CompilerEvent( CompilerEvent.COMPILER_ERROR );
			compilerEvent.output = output;
			dispatchEvent( compilerEvent );
		}
		
		protected function handleIOError( event:IOErrorEvent ):void
		{
			LOG.debug( "handleIOError" );
			
			errorFlag = true;
		}
		
		protected function handleProcessExit( event:NativeProcessExitEvent ):void
		{
			LOG.debug( "handleProcessExit" );
			
			if( errorFlag )
			{
				
			}
			else
			{
				
			}
		}
	}
}