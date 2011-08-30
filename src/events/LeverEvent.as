package events
{
	import flash.events.Event;
	
	public class LeverEvent extends Event
	{
		public var vidID:uint;
		public static var CLICKED:String = "clicked";
		public static var HIDE_VIDEO:String = "hideVideo";
		
		public function LeverEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}