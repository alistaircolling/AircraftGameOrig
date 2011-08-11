package controllers
{
	import model.UserDataModel;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	import services.GameIDService;
	
	import signals.ChangeState;
	import signals.StartClicked;
	
	public class RestartCommand extends SignalCommand
	{
		//reset the data on the model
		[Inject]
		public var userModel:UserDataModel;
		[Inject]
		public var changeState:ChangeState;
		[Inject]
		public var gameIDService:GameIDService;
		
		
		override public function execute():void{
			//increment the game ID
			userModel.gameID ++;
			
			//update the xml file
			gameIDService.updateID( userModel.gameID );
			
			changeState.dispatch(ChangeState.INTRO_SCREEN);
			
			
		}
	}
}