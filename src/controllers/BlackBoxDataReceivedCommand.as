package controllers
{
	import model.UserDataModel;
	import model.vo.ReceivedDataVO;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	import services.InitialXMLService;
	
	import utils.DataUtils;
	
	public class BlackBoxDataReceivedCommand extends SignalCommand
	{
		[Inject]
		public var xml:XML;//received form black box
		[Inject]
		public var userModel:UserDataModel;
		[Inject]
		public var intialXMLService:InitialXMLService;
		
		
		override public function execute():void{
			
			
			var vo:ReceivedDataVO = new ReceivedDataVO();
			vo.currentReliability = DataUtils.getObjectForValue(userModel.vo.reliability, Number(xml..currentReliability));
			vo.currentNFF = DataUtils.getObjectForValue(userModel.vo.nff, xml..currentNFF);
			vo.currentTuranaround = DataUtils.getObjectForValue(userModel.vo.turnaround, xml..currentTurnaround);
			vo.currentSpares = Number(xml..currentSpares);
			vo.sparesCostInc = userModel.vo.sparesCostInc;//already set and so retrieved
			
			//update vectors to start at minimum values
			vo.reliability = DataUtils.getVectorFromStartingVO(userModel.vo.reliability, vo.currentReliability);
			vo.nff = DataUtils.getVectorFromStartingVO(userModel.vo.nff, vo.currentNFF);
			vo.turnaround = DataUtils.getVectorFromStartingVO(userModel.vo.turnaround, vo.currentTuranaround);
			vo.initialData = false;
			//set on the model
			
			userModel.vo = vo;
			
			//set the iteration on the model
			userModel.iteration = xml..iteration;
			userModel.budget = Number(xml..currentBudget);//set the budget last otherwise it is updated in the intropanel when the vo.spares values are updated
			
			//create the graphresult vo
			
			
			
			
			
		}
		
	}
}