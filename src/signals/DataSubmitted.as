package signals
{
	import model.vo.InputVO;
	
	import org.osflash.signals.Signal;
	
	public class DataSubmitted extends Signal
	{
		public function DataSubmitted()
		{
			super(InputVO);
		}
	}
}