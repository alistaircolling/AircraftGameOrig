package events
{
	import flash.events.Event;
	
	public class NumberEvent extends Event
	{
		public static const BALANCE_UPDATE:String = "balanceUpdate";
		public var value:Number;
		
		public function NumberEvent(type:String, val:Number)
		{
			value = val;
			super(type, true, true);
		}
	}
}