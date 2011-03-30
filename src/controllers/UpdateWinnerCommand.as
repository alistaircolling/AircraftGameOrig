package controllers
{
	import model.UserDataModel;
	import model.vo.UserVO;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	import services.LeaderBoardService;
	//used to update the display as a user enters his name
	public class UpdateWinnerCommand extends SignalCommand
	{
		[Inject]
		public var position:int;
		[Inject]
		public var userVO:UserVO;
		[Inject]
		public var addToList:Boolean;
		[Inject]
		public var lBService:LeaderBoardService;
		
		
		override public function execute():void{
			
			lBService.updateWinnersListTemp(userVO, position, addToList);
			
		}
	}
}