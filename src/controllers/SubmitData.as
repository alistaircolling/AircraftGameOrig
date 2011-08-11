package controllers
{
	import model.UserDataModel;
	import model.vo.InputVO;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	import services.BlackBoxService;
	
	import signals.StatusUpdate;
	
	public class SubmitData extends SignalCommand
	{
		[Inject]
		public var blackBox:BlackBoxService;
		[Inject]
		public var vo:InputVO;
		[Inject]
		public var userModel:UserDataModel;
		[Inject]
		public var statusUpdate:StatusUpdate;
		
		override public function execute():void{
			
			statusUpdate.dispatch("submit data command");
			//add the iteration and game ID
			vo.gameID = userModel.gameID.toString();
			statusUpdate.dispatch("got game ID:"+vo.gameID);
			
			blackBox.sendData(vo);
			
		}
	}
}