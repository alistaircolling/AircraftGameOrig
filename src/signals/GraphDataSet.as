package signals
{
	import model.vo.GraphResultsVO;
	
	import org.osflash.signals.Signal;
	
	public class GraphDataSet extends Signal
	{
		public function GraphDataSet()
		{
			super(GraphResultsVO);
		}
	}
}