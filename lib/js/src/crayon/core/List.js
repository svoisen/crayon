(function( window )
{
  List = function( array )
  {
    this.array = array;
    this.length = array.length;
  }

  var p = List.prototype;

  p.array = null;
  p.length = 0;

  p.item_at = function( index )
  {
    return array[index];
  }

  p.empty = function()
  {
    array.length = 0;
  }

  p.push = function( item )
  {
    array.push( item );
  }

  p.pop = function()
  {
    return array.pop();
  }

  window.List = List;

}(window));
