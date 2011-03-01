package org.voisen.crayon.util
{
  public class ParamsUtil
  {
    public static function setupParams( defaultParamName:String, params:Object ):Object
    {
      if( params.__default )
      {
        params[defaultParamName] = params.__default;
      }

      return params;
    }
  }
}
