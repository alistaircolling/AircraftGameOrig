package controllers
{
	import model.UserDataModel;
	import model.vo.InputVO;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	import services.BlackBoxService;
	
	public class SubmitData extends SignalCommand
	{
		[Inject]
		public var blackBox:BlackBoxService;
		[Inject]
		public var vo:InputVO;
		[Inject]
		public var userModel:UserDataModel;
		
		override public function execute():void{
			
			//add the iteration and game ID
			vo.iteration = userModel.iteration;
			vo.gameID = userModel.gameID;
			
			blackBox.sendData(vo);
			
		}
	}
}