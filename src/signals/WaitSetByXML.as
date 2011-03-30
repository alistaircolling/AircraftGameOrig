package signals
{
	import org.osflash.signals.Signal;
	
	public class WaitSetByXML extends Signal
	{
		public function WaitSetByXML()
		{
			super(int);//passes the number of milliseconds wait
		}
	}
}