package utils
{
	public class StringUtils
	{
		public static function hasMinus( s:String ):Boolean{
			
			var retB:Boolean = false;
			if (s.substr(0,1) == "-"){
				retB = true;
			}
			return retB;
		}
	}
}