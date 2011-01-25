package events
{
	import flash.events.Event;
	
	public class PlanesEvent extends Event
	{
		public static const IN_AIR:String = "inAir";
		public static const ON_GROUND:String = "onGround";
		public var num:uint;
		
		public function PlanesEvent(type:String, n:uint, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			num = n;
			super(type, bubbles, cancelable);
		}
	}
}