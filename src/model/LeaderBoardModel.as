package model
{
	import model.vo.LeaderBoardVO;
	
	import org.robotlegs.mvcs.Actor;
	
	import signals.LeaderBoardSet;
	
	public class LeaderBoardModel extends Actor
	{
		[Inject]
		public var leaderBoardSet:LeaderBoardSet;
		
		public var xml:XML;//used by final screen to write back to xml file
		
		private var lbVO:LeaderBoardVO;

		public function get vo():LeaderBoardVO
		{
			return lbVO;
		}

		public function set vo(value:LeaderBoardVO):void
		{
			lbVO = value;
			leaderBoardSet.dispatch(lbVO);
		}

	}
}