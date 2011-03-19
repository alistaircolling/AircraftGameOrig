package controllers
{
	import model.UserDataModel;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class GameTypeSelectedCommand extends SignalCommand
	{
		[Inject]
		public var type:String;
		[Inject]
		public var userDataModel:UserDataModel;
		
		override public function execute():void{
			
			userDataModel.gameType = type;
			
		}
	}
}