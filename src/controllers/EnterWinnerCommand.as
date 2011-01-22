package controllers
{
	import model.UserDataModel;
	import model.vo.UserVO;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	import services.LeaderBoardService;
	
	public class EnterWinnerCommand extends SignalCommand
	{
		[Inject]
		public var lBService:LeaderBoardService;
		[Inject]
		public var userModel:UserDataModel;
		[Inject]
		public var position:uint;
		[Inject]
		public var initials:String;
		
		override public function execute():void{
			
			var vo:UserVO = new UserVO();
			vo.label = initials.substr(0,3);
			vo.score = userModel.vo.finalScore; 
			lBService.writeToXML(vo, position);
			
		}
	}
}