package signals
{
	import model.vo.LeaderBoardVO;
	
	import org.osflash.signals.Signal;
	
	public class LeaderBoardSet extends Signal
	{
		public function LeaderBoardSet()
		{
			super(LeaderBoardVO);
		}
	}
}