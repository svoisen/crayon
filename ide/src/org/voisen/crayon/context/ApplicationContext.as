package org.voisen.crayon.context
{
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObjectContainer;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.base.SignalCommandMap;
	import org.robotlegs.core.ISignalCommand;
	import org.robotlegs.mvcs.SignalContext;
	import org.voisen.crayon.command.shutdown.ShutdownApplicationCommand;
	import org.voisen.crayon.command.startup.StartupApplicationCommand;

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
			(injector.instantiate(StartupApplicationCommand) as ISignalCommand).execute();
		}
		
		override public function shutdown():void
		{
			(injector.instantiate(ShutdownApplicationCommand) as ISignalCommand).execute();
		}
	}
}