package model.vo
{
	public class SettingsVO
	{
		private var _exampleValue:String;
		
		public function SettingsVO(__xml:XML):void{
			
			_exampleValue = __xml.exampleValue.valueOf();
			
		}
		
		public function get exampleValue():String
		{
			return _exampleValue;
		}

		public function set exampleValue(value:String):void
		{
			_exampleValue = value;
		}

		
		
	
	}
}