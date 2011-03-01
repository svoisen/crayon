package org.voisen.crayon.core
{
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

    public function push( item:Object ):void
    {
      array.push( item );
    }

    public function pop():Object
    {
      return array.pop();
    }
  }
}
