package controllers
{
	import org.robotlegs.mvcs.SignalCommand;
	
	import services.BlackBoxService;
	
	public class InitSocketCommand extends SignalCommand
	{
		[Inject]
		public var blackBoxService:BlackBoxService
		
		override public function execute():void{
			
			blackBoxService.init();
			
		}
		
	}
}