package org.voisen.crayon.signal
{
	import flash.display.Stage;
	
	import org.osflash.signals.Signal;

	public class ApplicationSignalBus
	{
		public const initializeApplicationSignal:Signal = new Signal( Stage );
		public const runSketchSignal:Signal = new Signal( String );
	}
}