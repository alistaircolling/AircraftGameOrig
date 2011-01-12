package controllers
{
	import model.ExampleModel;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.mvcs.SignalCommand;
	
	import services.BlackBoxService;
	import services.LeaderBoardService;
	
	import signals.ChangeState;
	
	public class StartClickedCommand extends SignalCommand
	{
	
		[Inject]
		public var blackBoxService:BlackBoxService;
		[Inject]
		public var leaderBoardService:LeaderBoardService;
		[Inject]
		public var changeState:ChangeState;
		
		
		
		override public function execute():void{
			
			trace("start clicked command, requesting intial data from services.....");
			blackBoxService.requestInitialData();
			leaderBoardService.requestData();
			
		
		}
		
		
	}
}