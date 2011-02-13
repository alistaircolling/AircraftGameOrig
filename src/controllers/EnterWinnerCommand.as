package controllers
{
	import model.LeaderBoardModel;
	import model.UserDataModel;
	import model.vo.UserVO;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	import services.LeaderBoardService;
	
	public class EnterWinnerCommand extends SignalCommand
	{
		[Inject]
		public var lBService:LeaderBoardService;
		[Inject]
		public var lbModel:LeaderBoardModel;
		[Inject]
		public var userModel:UserDataModel;
		
		override public function execute():void{
			
			lBService.writeToXML();
			
		}
	}
}