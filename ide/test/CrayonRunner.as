package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.flexunit.internals.TraceListener;
	import org.flexunit.listeners.CIListener;
	import org.flexunit.runner.FlexUnitCore;
	import org.flexunit.runner.notification.async.XMLListener;
	import org.voisen.crayon.CrayonSuite;
	
	public class CrayonRunner extends Sprite
	{
		public var core:FlexUnitCore;
		
		public function CrayonRunner()
		{
			NativeApplication.nativeApplication.autoExit = false;
			
			core = new FlexUnitCore();
			
            core.addListener(new TraceListener());
            core.addListener(new CIListener());
            core.addListener(new XMLListener());
			
            core.run(CrayonSuite);
			
			core.addEventListener(FlexUnitCore.TESTS_COMPLETE, completeHandler);
		}
		
		protected function completeHandler(event:Event):void
		{
			NativeApplication.nativeApplication.exit();
		}
	}
}