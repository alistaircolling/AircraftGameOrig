package signals
{
	import org.osflash.signals.Signal;
	
	public class GameTypeSelected extends Signal
	{
		public function GameTypeSelected()
		{
			super(String);
		}
	}
}