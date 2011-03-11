package org.voisen.crayon.support.editorwindow
{
	import flash.geom.Rectangle;
	
	import org.voisen.crayon.view.editor.EditorWindow;
	
	public class MockCenteredEditorWindow extends EditorWindow
	{
		public var centeredRect:Rectangle;
		
		public function MockCenteredEditorWindow()
		{
		}
		
		override public function center(screenRect:Rectangle = null):void
		{
			centeredRect = screenRect;
		}
	}
}