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
		
		var _timer:Timer;   //todo remove timer as this is for testing only
		
		public function requestInitialData():void{
			statusUpdate.dispatch("black box requesting initial data.....");
			_timer = new Timer(400, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timComplete);
			_timer.start();
		}
		
		private function timComplete( t:TimerEvent ):void{
			
			dataReceived();
			
		}
		
		
		private function dataReceived():void{
			statusUpdate.dispatch("black box data received");
			//todo  add xml parsing to populate the vo
			
			var vo:InputDataVO = new InputDataVO();
			
			vo.budget = 100000;
			vo.iteration = 0;
			vo.currentReliability = 43;
			vo.currentTuranaround = 24;
			vo.currentNFF = 5.6;
			vo.currentSpares = 100;
			vo.sparesInc = .4;
			vo.sparesMin = 0;
			
			//iterate through the values 
			var reliability:Vector.<InputObjectVO> = new Vector.<InputObjectVO>();
			for (var i:uint = 0; i<5; i++){
				var obj:InputObjectVO = new InputObjectVO();
				obj.cost = i*2;
				obj.value = i*9;
				reliability.push(obj);
			}

			var nff:Vector.<InputObjectVO> = new Vector.<InputObjectVO>();
			for (i = 0; i<5; i++){
				obj = new InputObjectVO();
				obj.cost = i*1;
				obj.value = i*8;
				nff.push(obj);
				
			}
			
			var turnaround:Vector.<InputObjectVO> = new Vector.<InputObjectVO>();
			for (i=0; i<5; i++){
				obj = new InputObjectVO();
				obj.cost = i*3;
				obj.value = i*11;
				turnaround.push(obj);				
			}
			
			vo.nff = nff;
			vo.reliability = reliability;
			vo.turnaround = turnaround;
			
			userModel.vo = vo;
			
			
		}
	}
}