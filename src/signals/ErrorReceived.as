package signals
{
	import model.vo.ErrorVO;
	
	import org.osflash.signals.Signal;
	
	public class ErrorReceived extends Signal
	{
		public function ErrorReceived()
		{
			super(String);
		}
	}
}