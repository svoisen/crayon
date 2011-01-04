package org.voisen.crayon.controller
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	
	import mx.logging.ILogger;
	
	import org.voisen.crayon.business.CompilerDelegate;
	import org.voisen.crayon.business.FileIODelegate;
	import org.voisen.crayon.business.LogDelegate;
	import org.voisen.crayon.business.MenuDelegate;
	import org.voisen.crayon.event.CompilerEvent;
	import org.voisen.crayon.event.ConsoleEvent;
	import org.voisen.crayon.model.ApplicationModel;
	import org.voisen.crayon.util.LogUtil;

	public class ApplicationController
	{
		[Inject]
		public var applicationModel:ApplicationModel;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		private static const LOG:ILogger = LogUtil.getLogger( ApplicationController );
		
		[EventHandler( event="InitializationEvent.APP_INIT", properties="stage" )]
		public function initializeApplication( stage:Stage ):void
		{
			new LogDelegate().setupLogging();
			
			new MenuDelegate().setupMenus( stage );
		}
		
		[EventHandler( event="SketchEvent.RUN_SKETCH", properties="sketch" )]
		public function runSketch( sketch:String ):void
		{
			LOG.debug( "runSketch" );
			
			if( !NativeProcess.isSupported )
			{
				LOG.error( "NativeProcess is not supported" );
				return;
			}
			
			var fileDelegate:FileIODelegate = new FileIODelegate();
			var sourceFile:File = fileDelegate.saveToTempFile( sketch );
			
			LOG.debug( "Saved sketch to: " + sourceFile.nativePath );
			
			var compilerDelegate:CompilerDelegate = new CompilerDelegate();
			compilerDelegate.addEventListener( CompilerEvent.COMPILER_ERROR, handleCompilerError );
			compilerDelegate.compile( sourceFile );
		}
		
		protected function handleCompilerError( event:CompilerEvent ):void
		{
			LOG.debug( "handleCompilerError" );
			
			var consoleEvent:ConsoleEvent = new ConsoleEvent( ConsoleEvent.SHOW_TEXT );
			consoleEvent.text = event.output;
			dispatcher.dispatchEvent( consoleEvent );
		}
	}
}