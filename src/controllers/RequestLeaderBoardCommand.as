package controllers
{
	import model.LeaderBoardModel;
	import model.vo.LeaderBoardVO;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	import signals.LeaderBoardSet;
	
	public class RequestLeaderBoardCommand extends SignalCommand
	{
		[Inject]
		public var leaderBoardModel:LeaderBoardModel;
		[Inject]
		public var leaderBoardSet:LeaderBoardSet;
		
		override public function execute():void{
			
			var vo:LeaderBoardVO = leaderBoardModel.vo;
			leaderBoardSet.dispatch(vo);
			
		}
	}
}