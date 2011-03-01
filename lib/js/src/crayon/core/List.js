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
    return this.array[index];
  }

  p.empty = function()
  {
    this.array.length = 0;
  }

  p.push = function( item )
  {
    this.array.push( item );
  }

  p.pop = function()
  {
    return this.array.pop();
  }

  window.List = List;

}(window));
