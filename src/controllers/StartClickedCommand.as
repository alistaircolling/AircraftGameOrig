package controllers
{
	import model.ExampleModel;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.mvcs.SignalCommand;
	
	import services.BlackBoxService;
	import services.InitialXMLService;
	import services.LeaderBoardService;
	
	import signals.ChangeState;
	
	public class StartClickedCommand extends SignalCommand
	{
	
		[Inject]
		public var leaderBoardService:LeaderBoardService;
		[Inject]
		public var changeState:ChangeState;
		[Inject]
		public var initXMLService:InitialXMLService;
		
		
		
		override public function execute():void{
			
			trace("start clicked command, loading intial XML.....");
			leaderBoardService.requestData();
			initXMLService.loadXML("data/initParams.xml");
		
		}
		
		
	}
}