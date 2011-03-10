package org.voisen.crayon.view.menu.model
{
	import mx.logging.ILogger;
	
	import org.voisen.crayon.model.ApplicationModel;
	import org.voisen.crayon.signal.ApplicationSignalBus;
	import org.voisen.crayon.signal.EditorSignalBus;
	import org.voisen.crayon.util.LogUtil;

	public class FileMenuModel
	{
		[Inject]
		public var editorSignalBus:EditorSignalBus;
		
		[Inject]
		public var applicationSignalBus:ApplicationSignalBus;
		
		[Inject]
		public var model:ApplicationModel;
		
		private static const LOG:ILogger = LogUtil.getLogger( FileMenuModel );
		
		public function createSketch():void
		{
			LOG.debug( "createSketch" );
		}
		
		public function openSketch():void
		{
			LOG.debug( "openSketch" );
			editorSignalBus.openFileSignal.dispatch( model.currentEditor );
		}
		
		public function runSketch():void
		{
			LOG.debug( "runSketch" );
			applicationSignalBus.runSketchSignal.dispatch( model.currentEditor.buffer );
		}
		
		public function saveSketch():void
		{
			LOG.debug( "saveSketch" );
			editorSignalBus.saveFileSignal.dispatch( model.currentEditor );
		}
	}
}