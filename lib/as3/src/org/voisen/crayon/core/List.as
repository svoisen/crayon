package org.voisen.crayon.core
{
  import org.voisen.crayon.util.ParamsUtil;

  public class List
  {
    protected var array:Array;

    public function List( data:Array )
    {
      array = data;
    }

    public function get length():int
    {
      return array.length;
    }

    public function item_at( index:int ):Object
    {
      return array[index];
    }

    public function empty():void
    {
      array.length = 0;
    }

    public function push( params:Object ):void
    {
      params = ParamsUtil.setupParams( "item", params );
      array.push( params.item );
    }

    public function pop():Object
    {
      return array.pop();
    }
  }
}
