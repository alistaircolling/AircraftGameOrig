package utils
{
	import org.robotlegs.mvcs.Actor;
	
	import signals.StatusUpdate;
	
	public class Logger extends Actor
	{
		[Inject]
		public var statusUpdate:StatusUpdate;
		
		public function log( s:String ):void
		{
			statusUpdate.dispatch(s);
		}
	}
}