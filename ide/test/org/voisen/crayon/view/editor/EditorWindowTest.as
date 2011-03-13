package org.voisen.crayon.view.editor
{
	import com.destroytoday.window.Window;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.Screen;
	
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.voisen.crayon.support.editorwindow.MockCenteredEditorWindow;

	public class EditorWindowTest
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		protected var window:EditorWindow;
		
		//--------------------------------------------------------------------------
		//
		//  Prep
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function setUp():void
		{
			window = new EditorWindow();
		}
		
		[After]
		public function tearDown():void
		{
			closeAllWindows();
			
			window = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected Methods
		//
		//--------------------------------------------------------------------------
		
		protected function closeAllWindows():void
		{
			for each (var window:NativeWindow in NativeApplication.nativeApplication.openedWindows)
				window.close();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test]
		public function should_extend_window():void
		{
			assertThat(window is Window);
		}
		
		[Test]
		public function should_have_600_x_600_stage_dimensions_by_default():void
		{
			assertThat(window.stage.stageWidth, equalTo(600.0));
			assertThat(window.stage.stageHeight, equalTo(600.0));
		}
		
		[Test]
		public function should_add_editor_view_to_stage():void
		{
			assertThat(window.stage.getChildAt(0) is EditorView);
		}
	}
}