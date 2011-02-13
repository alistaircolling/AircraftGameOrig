package events
{
	import flash.events.Event;
	
	public class UpdateLetterEvent extends Event
	{
		public static const LETTER_CHANGED:String = "letterChanged";
		public var letter:String;
		public var id:uint;
		
		public function UpdateLetterEvent(type:String, l:String, ident:uint)
		{
			letter = l;
			id = ident;
			super(type, true, false);
		}
	}
}