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
	import org.voisen.crayon.model.ApplicationModel;
	import org.voisen.crayon.signal.ApplicationSignalBus;
	import org.voisen.crayon.signal.EditorSignalBus;
	import org.voisen.crayon.util.LogUtil;

	public class ApplicationController
	{
		[Inject]
		public var applicationModel:ApplicationModel;
		
		[Inject]
		public var fileDelegate:FileIODelegate;
		
		[Inject]
		public var compilerDelegate:CompilerDelegate;
		
		[Inject]
		public var logDelegate:LogDelegate;
		
		[Inject]
		public var menuDelegate:MenuDelegate;
		
		[Inject]
		public var signalBus:ApplicationSignalBus;
		
		[Inject]
		public var editorSignalBus:EditorSignalBus;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		private static const LOG:ILogger = LogUtil.getLogger( ApplicationController );
		
		[PostConstruct]
		public function setupSignalBus():void
		{
			signalBus.initializeApplicationSignal.add( initializeApplication );
			signalBus.runSketchSignal.add( runSketch );
		}
		
		[PreDestroy]
		public function clearSignalBus():void
		{
			signalBus.initializeApplicationSignal.remove( initializeApplication );
			signalBus.runSketchSignal.remove( runSketch );
		}
		
		/**
		 * Called after application is created to do initial bootstrapping and
		 * initialization.
		 */
		public function initializeApplication( stage:Stage ):void
		{
			logDelegate.setupLogging();
			menuDelegate.setupMenus( stage );
		}
		
		public function runSketch( sketch:String ):void
		{
			LOG.debug( "runSketch" );
			
			if( !NativeProcess.isSupported )
			{
				// TODO: Handle error
				LOG.error( "NativeProcess is not supported" );
				return;
			}
			
			var sourceFile:File = fileDelegate.saveToTempFile( sketch );
			
			LOG.debug( "Saved sketch to: " + sourceFile.nativePath );
			
			compilerDelegate.errorSignal.add( handleCompilerError );
			compilerDelegate.outputSignal.add( handleCompilerOutput );
			compilerDelegate.compile( sourceFile );
		}
		
		protected function handleCompilerOutput( output:String ):void
		{
			LOG.debug( "handleCompilerOutput" );
			
			compilerDelegate.clearSignals();
			editorSignalBus.showInConsoleSignal.dispatch( output );
		}
		
		protected function handleCompilerError( output:String ):void
		{
			LOG.debug( "handleCompilerError" );
			
			compilerDelegate.clearSignals();
			editorSignalBus.showInConsoleSignal.dispatch( output );
		}
	}
}