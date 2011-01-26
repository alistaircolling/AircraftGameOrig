package events
{
	import flash.events.Event;
	
	public class SocketEvent extends Event
	{
		public static const ANY:String = "any";
		public var msg:String;
		
		public function SocketEvent( s:String )
		{
			msg = s;
			super(ANY, true, false);
		}
	}
}