package
{
  import flash.display.Sprite;
  import flash.events.Event;

  public class CrayonProgram extends Sprite
  {
    public function CrayonProgram()
    {
      setup();
      addEventListener(Event.ENTER_FRAME, function(event:Event):void{loop();});
    }

    protected function setup()
    {
    }

    protected function loop()
    {
    }

    protected function callWithNamedParams(func:Function, params:Object)
    {
    }
  }
}
