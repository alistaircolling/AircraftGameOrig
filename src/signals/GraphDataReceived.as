package signals
{
	import model.vo.GraphResultsVO;
	
	import org.osflash.signals.Signal;
	
	public class GraphDataReceived extends Signal
	{
		public function GraphDataReceived()
		{
			super(GraphResultsVO);
		}
	}
}