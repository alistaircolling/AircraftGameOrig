package services
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import model.UserDataModel;
	import model.vo.InputDataVO;
	import model.vo.InputObjectVO;
	
	import org.robotlegs.mvcs.Actor;
	
	import signals.StatusUpdate;
	
	public class BlackBoxService extends Actor
	{
		
		[Inject]
		public var userModel:UserDataModel;
		[Inject]
		public var statusUpdate:StatusUpdate;
		
		private var _timer:Timer;   //todo remove timer as this is for testing only
		
		public function requestInitialData():void{
			statusUpdate.dispatch("black box requesting initial data.....");
			_timer = new Timer(400, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timComplete);
			_timer.start();
		}
		
		private function timComplete( t:TimerEvent ):void{
			
			dataReceived();
			
		}
		
		private function getVOFromVector( n:Number, vector:Vector.<InputObjectVO> ):InputObjectVO{
			var retVO:InputObjectVO;
			var inputObjVO:InputObjectVO;
			for each(inputObjVO in vector){
				if (inputObjVO.value == n){
					retVO = inputObjVO;					
				}
			}
			if (retVO ==null){
				trace("NO VALUE MATCHES !!!!!! error in blackboxservice");
			}
			return retVO;
		}
		
		private function dataReceived():void{
			statusUpdate.dispatch("black box data received");
			//todo  add xml parsing to populate the vo
			
			var vo:InputDataVO = new InputDataVO();
			
			vo.budget = 100000;
			vo.iteration = 0;
			
			vo.sparesInc = .4;
			vo.sparesMin = 0;
			
			
			//iterate through the values 
			var reliability:Vector.<InputObjectVO> = new Vector.<InputObjectVO>();
			for (var i:uint = 0; i<5; i++){
				var obj:InputObjectVO = new InputObjectVO();
				obj.cost = i*10;
				obj.value = i;
				obj.theIndex = i;
				reliability.push(obj);
			}

			var nff:Vector.<InputObjectVO> = new Vector.<InputObjectVO>();
			for (i = 0; i<5; i++){
				var nffObj:InputObjectVO = new InputObjectVO();
				nffObj.cost = i*10;
				nffObj.value = i;
				nffObj.theIndex = i;
				nff.push(nffObj);
				
			}
			
			var turnaround:Vector.<InputObjectVO> = new Vector.<InputObjectVO>();
			for (i=0; i<5; i++){
				var ipvo:InputObjectVO = new InputObjectVO();
				ipvo = new InputObjectVO();
				ipvo.cost = i*10;
				ipvo.value = i;
				ipvo.theIndex = i;
				turnaround.push(ipvo);				
			}
			
			vo.currentReliability = getVOFromVector(1, reliability);
			vo.currentTuranaround = getVOFromVector(2, turnaround);
			vo.currentNFF = getVOFromVector(3, nff);
			vo.currentSpares = 100;
			
			//set the vectors
			vo.nff = nff;
			vo.reliability = reliability;
			vo.turnaround = turnaround;
			
			userModel.vo = vo;
			
			
		}
	}
}