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
			window = new EditorWindow();
			
			assertThat(window is Window);
		}
		
		[Test]
		public function should_have_title_crayon_by_default():void
		{
			window = new EditorWindow();
			
			assertThat(window.title, equalTo('Crayon'));
		}
		
		[Test]
		public function should_have_600_x_600_stage_dimensions_by_default():void
		{
			window = new EditorWindow();
			
			assertThat(window.stage.stageWidth, equalTo(600.0));
			assertThat(window.stage.stageHeight, equalTo(600.0));
		}
		
		[Test]
		public function should_center_on_main_screen_by_default():void
		{
			var window:MockCenteredEditorWindow = new MockCenteredEditorWindow();
			
			assertThat(window.centeredRect.equals(Screen.mainScreen.visibleBounds));
		}
	}
}