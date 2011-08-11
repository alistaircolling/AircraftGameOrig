package controllers
{
	
	
	
	import org.robotlegs.mvcs.SignalCommand;
	
	import services.CompiledXMLService;
	import services.LeaderBoardService;
	
	public class LoadLeaderBoardXML extends SignalCommand
	{
		[Inject]
		public var leaderBoard:LeaderBoardService;
		
		
		override public function execute():void{
			leaderBoard.requestData();
			
		}
	}
}