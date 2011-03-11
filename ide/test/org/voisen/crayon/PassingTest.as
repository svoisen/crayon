package org.voisen.crayon
{
	import org.hamcrest.assertThat;

	public class PassingTest
	{		
		[Test]
		public function should_pass():void
		{
			assertThat(true);
		}
	}
}