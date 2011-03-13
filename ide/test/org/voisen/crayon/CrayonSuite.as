package org.voisen.crayon
{
	import org.voisen.crayon.command.shutdown.CloseAllWindowsCommandTest;
	import org.voisen.crayon.command.startup.CreateWorkspaceCommandTest;
	import org.voisen.crayon.context.ApplicationContextTest;
	import org.voisen.crayon.view.editor.EditorWindowTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class CrayonSuite
	{
		//--------------------------------------------------------------------------
		//
		//  Contexts
		//
		//--------------------------------------------------------------------------
		
		public var applicationContextTest:ApplicationContextTest;
		
		//--------------------------------------------------------------------------
		//
		//  Commands
		//
		//--------------------------------------------------------------------------
		
		public var createWindowsCommandTest:CreateWorkspaceCommandTest;
		
		public var closeAllWindowsCommandTest:CloseAllWindowsCommandTest;
		
		//--------------------------------------------------------------------------
		//
		//  Views
		//
		//--------------------------------------------------------------------------
		
		public var editorWindowTest:EditorWindowTest;
	}
}