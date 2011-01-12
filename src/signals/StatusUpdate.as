package signals
{
	import org.osflash.signals.Signal;
	
	public class StatusUpdate extends Signal
	{
		public function StatusUpdate()
		{
			super(String);
		}
	}
}