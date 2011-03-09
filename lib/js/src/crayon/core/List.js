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

  p.__defineGetter__('_collection', function(){ return this.array; });

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
