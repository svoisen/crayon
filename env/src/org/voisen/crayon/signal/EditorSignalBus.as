package org.voisen.crayon.signal
{
	import org.osflash.signals.Signal;
	import org.voisen.crayon.view.component.IEditor;

	public class EditorSignalBus
	{
		public const createSketchSignal:Signal = new Signal();
		public const openFileSignal:Signal = new Signal( IEditor );
		public const saveFileSignal:Signal = new Signal( IEditor );
		public const showInConsoleSignal:Signal = new Signal( String );
	}
}