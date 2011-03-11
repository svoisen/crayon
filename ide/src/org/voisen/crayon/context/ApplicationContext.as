package org.voisen.crayon.context
{
	import flash.display.DisplayObjectContainer;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.SignalContext;
	import org.voisen.crayon.command.startup.StartupCommand;

	public class ApplicationContext extends SignalContext
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function ApplicationContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true)
		{
			super(contextView, autoStartup);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		override public function startup():void
		{
			trace("ApplicationContext.startup()");
			
			var started:Signal = new Signal();
			
			signalCommandMap.mapSignal(started, StartupCommand, true);
			
			started.dispatch();
		}
	}
}