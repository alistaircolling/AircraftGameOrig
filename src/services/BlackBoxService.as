
package services
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import model.UserDataModel;
	import model.vo.InputObjectVO;
	import model.vo.InputVO;
	import model.vo.ReceivedDataVO;
	
	import org.robotlegs.mvcs.Actor;
	
	import signals.BlackBoxDataReceived;
	import signals.StatusUpdate;
	
	public class BlackBoxService extends Actor
	{
		
		[Inject]
		public var userModel:UserDataModel;
		[Inject]
		public var statusUpdate:StatusUpdate;
		[Inject]
		public var bBDataReceived:BlackBoxDataReceived;
		
		private var _timer:Timer;   //todo remove timer as this is for testing only
		
		private var _dummy1:String = ( <![CDATA[<?xml version="1.0" encoding="UTF-8" ?><resultParams><gameID>1234</gameID><iteration>1</iteration><currentReliability>15.6</currentReliability><currentNFF>40</currentNFF><currentTurnaround>21</currentTurnaround><currentSpares>125</currentSpares><currentBudget>19.1</currentBudget><percentFlown>67.3,65.9,67.3,66.6,68.6,67.3,74.5,74.8,79.9,77.5,84.5,82.4,87.5,83.3,85.8,84.1,86.7,83.2,87.5,82.4,86.7,85.8,85.8,82.4</percentFlown><monthTotal>-7.5,-7.6,-7.5,-0.2,-0.0,-0.1,0.5,0.6,1.0,0.6,1.5,1.4,1.6,1.5,1.7,1.6,1.7,1.6,1.7,1.5,1.7,1.7,1.7,1.5</monthTotal><inAir>7,7,8,8,9,8,9,8</inAir><onGround>3,3,2,2,1,2,1,2</onGround></resultParams>]]> ).toString();
		private var _dummy2:String = ( <![CDATA[<?xml version="1.0" encoding="UTF-8" ?><resultParams><gameID>1234</gameID><iteration>2</iteration><currentReliability>15.6</currentReliability><currentNFF>40</currentNFF><currentTurnaround>5</currentTurnaround><currentSpares>125</currentSpares><currentBudget>19.8</currentBudget><percentFlown>89.2,84.1,86.7,82.4,86.7,85.0,87.1,86.7,89.7,83.9,87.8,84.6,88.5,87.9,90.9,85.6,91.8,88.2,92.7,87.3,91.8,88.2,92.7,85.6</percentFlown><monthTotal>-7.9,-8.1,-8.0,-0.2,0.0,-0.0,0.1,0.0,0.1,-0.1,0.1,-0.0,0.1,0.1,2.5,2.3,2.5,2.4,2.6,2.4,2.5,2.4,2.6,2.3</monthTotal><inAir>9,8,9,8,9,9,9,9</inAir><onGround>1,2,1,2,1,1,1,1</onGround></resultParams>]]> ).toString();
		private var _dummy3:String = ( <![CDATA[<?xml version="1.0" encoding="UTF-8" ?><resultParams><gameID>1234</gameID><iteration>3</iteration><currentReliability>15.6</currentReliability><currentNFF>40</currentNFF><currentTurnaround>5</currentTurnaround><currentSpares>127</currentSpares><currentBudget>58.0</currentBudget><percentFlown>90.0,87.3,89.1,89.1,90.9,86.5,90.2,87.5,91.1,85.7,92.9,85.7,92.0,88.4,90.2,89.3,92.0,89.3,92.9,89.3,92.0,86.6,92.9,89.3</percentFlown><monthTotal>1.4,1.3,1.3,1.6,1.7,1.5,1.7,1.5,1.7,1.4,1.7,1.4,1.7,1.6,1.7,1.6,1.7,1.6,1.7,1.6,1.7,1.5,1.7,1.6</monthTotal><inAir>9,9,9,9,9,9,9,9</inAir><onGround>1,1,1,1,1,1,1,1</onGround><averageAvailability>89.6</averageAvailability></resultParams>]]> ).toString();
		
		private var _iteration:uint; //only used during dummy runs
		
		public function sendData( vo:InputVO ):void{
			//only used in testing
			
			_iteration = Number(vo.iteration);
			
			//create xml   TODO add socket connectivity
			var xmlStr:String = "<?xml version='1.0' encoding='UTF-8' ?><requestParams><gameID>"+vo.gameID+"</gameID><iteration>"+vo.iteration+"</iteration><reliabilityStep>"+vo.reliability+"</reliabilityStep><nffStep>"+vo.nff+"</nffStep><turnaroundStep>"+vo.turnaround+"</turnaroundStep><sparesBought>"+vo.spares+"</sparesBought></requestParams>";
			statusUpdate.dispatch("submitting to socket server......"+xmlStr);
			
			_timer = new Timer(400, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, dummyComplete);
			_timer.start();
			
		}
		
		private function dummyComplete( t:TimerEvent ):void{
			trace("dummy response");			
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, dummyComplete);
			_timer = null;
			var response:String = this["_dummy"+_iteration];
			dataReceived(response);
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
		
		private function dataReceived( s:String ):void{
			statusUpdate.dispatch("black box data received:  \n"+s);
			//todo  add xml parsing to populate the vo
			var xml:XML = new XML(s);
			bBDataReceived.dispatch(xml);
			
			
			
		}
	}
}