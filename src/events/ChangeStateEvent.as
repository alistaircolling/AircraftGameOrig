package events
{
	import flash.events.Event;
	
	public class ChangeStateEvent extends Event
	{
		public var state:String;
		
		public function ChangeStateEvent(type:String)
		{
			super(type, true, true);
		}
	}
}