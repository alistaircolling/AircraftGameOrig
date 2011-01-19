package controllers
{
	
	
	
	import org.robotlegs.mvcs.SignalCommand;
	
	import services.CompiledXMLService;
	import services.LeaderBoardService;
	
	public class LoadLeaderBoardXML extends SignalCommand
	{
		[Inject]
		public var leaderBoard:LeaderBoardService;
		
		//todo make this also load initial settings xml if necessary (not initial params)
		
		override public function execute():void{
			leaderBoard.requestData();
			
		}
	}
}