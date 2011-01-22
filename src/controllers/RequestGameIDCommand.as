package controllers
{
	import org.robotlegs.mvcs.SignalCommand;
	
	import services.GameIDService;
	
	public class RequestGameIDCommand extends SignalCommand
	{
		[Inject]
		public var gameIDService:GameIDService;
		
		override public function execute():void{
			gameIDService.requestID();			
		}
		
	}
}