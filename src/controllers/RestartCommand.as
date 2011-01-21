package controllers
{
	import model.UserDataModel;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	import signals.ChangeState;
	import signals.StartClicked;
	
	public class RestartCommand extends SignalCommand
	{
		//reset the data on the model
		[Inject]
		public var userModel:UserDataModel;
		[Inject]
		public var changeState:ChangeState;
		
		
		
		override public function execute():void{
			
			//userModel.iteration = 0;
			changeState.dispatch(ChangeState.INTRO_SCREEN);
			
			
		}
	}
}