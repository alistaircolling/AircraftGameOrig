package signals
{
	import org.osflash.signals.Signal;
	
	public class UpdateBalance extends Signal
	{
		public function UpdateBalance()
		{
			super(Number);
		}
	}
}