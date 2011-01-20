package events
{
	import flash.events.Event;
	
	public class ChangeStateEvent extends Event
	{
		public var state:String;
		
		public function ChangeStateEvent(type:String)
		{
			state = type;
			super(type, true, true);
		}
	}
}