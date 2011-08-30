
package services
{
	import events.SocketEvent;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import model.UserDataModel;
	import model.vo.InputObjectVO;
	import model.vo.InputVO;
	import model.vo.ReceivedDataVO;
	
	import org.robotlegs.mvcs.Actor;
	
	import services.socketUtils.CustomSocket;
	import services.socketUtils.SocketConnector;
	
	import signals.BlackBoxDataReceived;
	import signals.ErrorReceived;
	import signals.StatusUpdate;
	
	import utils.CustomEvent;
	
	public class BlackBoxService extends Actor
	{
		
		
		[Inject]
		public var userModel:UserDataModel;
		[Inject]
		public var statusUpdate:StatusUpdate;
		[Inject]
		public var bBDataReceived:BlackBoxDataReceived;
		[Inject]
		public var errorReceived:ErrorReceived;
		
		private static const MAX_ATTEMPTS:uint = 3;
		
		
		
		private var _socket:CustomSocket;
		private static const _port:String = "6780";
		private static const _ip:String = "127.0.0.1";
		
		private var _timer:Timer;   //todo remove timer as this is for testing only
		
		private var _dummy1:String = ( <![CDATA[<?xml version="1.0" encoding="UTF-8" ?><resultParams> <gameID>1234</gameID><iteration>1</iteration> <currentReliability>15.6</currentReliability><currentNFF>40</currentNFF> <currentTurnaround>21</currentTurnaround><currentSpares>121</currentSpares> <currentBudget>-19.1</currentBudget><percentFlown>67.3,65.9,67.3,66.6,68.6,67.3,74.5,74.8,79.9,77.5,84.5,82.4,87.5,83.3,85.8,84.1,86.7,83.2,87.5,82.4,86.7,85.8,85.8,82.4</percentFlown><monthTotal>-17.5,-17.6,-17.5,20.2,20.0,20.1,0.5,0.6,1.0,0.6,1.5,1.4,1.6,1.5,1.7,1.6,1.7,1.6,1.7,1.5,1.7,1.7,1.7,1.5</monthTotal><inAir>7,7,8,8,9,8,9,8</inAir> <onGround>3,3,2,2,1,2,1,2</onGround> </resultParams>]]> ).toString();
		private var _dummy2:String = ( <![CDATA[<?xml version="1.0" encoding="UTF-8" ?><resultParams><gameID>1234</gameID><iteration>2</iteration><currentReliability>15.6</currentReliability><currentNFF>40</currentNFF><currentTurnaround>5</currentTurnaround><currentSpares>122</currentSpares><currentBudget>-20.8</currentBudget><percentFlown>89.2,84.1,86.7,82.4,86.7,85.0,87.1,86.7,89.7,83.9,87.8,84.6,88.5,87.9,90.9,85.6,91.8,88.2,92.7,87.3,91.8,88.2,92.7,85.6</percentFlown><monthTotal>-7.9,-8.1,-8.0,-0.2,0.0,-0.0,0.1,0.0,0.1,-0.1,0.1,-0.0,0.1,0.1,2.5,2.3,2.5,2.4,2.6,2.4,2.5,2.4,2.6,2.3</monthTotal><inAir>9,8,9,8,9,9,9,9</inAir><onGround>1,2,1,2,1,1,1,1</onGround></resultParams>]]> ).toString();
		private var _dummy3:String = ( <![CDATA[<?xml version="1.0" encoding="UTF-8" ?><resultParams><gameID>1234</gameID><iteration>3</iteration><currentReliability>15.6</currentReliability><currentNFF>40</currentNFF><currentTurnaround>5</currentTurnaround><currentSpares>123</currentSpares><currentBudget>-58.0</currentBudget><percentFlown>90.0,87.3,89.1,89.1,90.9,86.5,90.2,87.5,91.1,85.7,92.9,85.7,92.0,88.4,90.2,89.3,92.0,89.3,92.9,89.3,92.0,86.6,92.9,89.3</percentFlown><monthTotal>1.4,1.3,1.3,1.6,1.7,1.5,1.7,1.5,1.7,1.4,1.7,1.4,1.7,1.6,1.7,1.6,1.7,1.6,1.7,1.6,1.7,1.5,1.7,1.6</monthTotal><inAir>9,9,9,9,9,9,9,9</inAir><onGround>1,1,1,1,1,1,1,1</onGround><averageAvailability>89.6</averageAvailability><costperFH>-30.4</costperFH></resultParams>]]> ).toString();
		
		private var _send1:String = ( <![CDATA[<?xml version="1.0" encoding="UTF-8" ?><requestParams><gameID>1234</gameID><iteration>1</iteration><reliabilityStep>2</reliabilityStep><nffStep>1</nffStep><turnaroundStep>3</turnaroundStep><sparesBought>5</sparesBought></requestParams>]]> ).toString();
		private var _send2:String = ( <![CDATA[<?xml version="1.0" encoding="UTF-8" ?><requestParams><gameID>1234</gameID><iteration>2</iteration><reliabilityStep>2</reliabilityStep><nffStep>1</nffStep><turnaroundStep>5</turnaroundStep><sparesBought>0</sparesBought></requestParams>
]]> ).toString();
		private var _send3:String = ( <![CDATA[<?xml version="1.0" encoding="UTF-8" ?><requestParams><gameID>1234</gameID><iteration>3</iteration><reliabilityStep>2</reliabilityStep><nffStep>1</nffStep><turnaroundStep>5</turnaroundStep><sparesBought>2</sparesBought></requestParams>
]]> ).toString();
		
		private var _sendTimer:Timer;
		private var _storedSendString:String;
		private var _checkReceived:Timer;
		private static const _checkWait:uint = 2000;
		
		private var _attempts:uint;
		//used to store the vo for resubmission
		private var _tempSubmitVO:InputVO;
		private var _resubmitTimer:Timer;
		
		private var _iteration:uint; //only used during dummy runs
		
		//to be used for local testing without a black box
		public function sendDataX( vo:InputVO ):void{
			_iteration = Number(vo.iteration);
			_tempSubmitVO = vo;
		
			//only used"_send in testing
			trace("Sending data for iteration:"+vo.iteration);
			
			var xmlStr:String = '<?xml version="1.0" encoding="UTF-8" ?><requestParams><gameID>'+vo.gameID+'</gameID><iteration>'+vo.iteration+'</iteration><reliabilityStep>'+vo.reliability+'</reliabilityStep><nffStep>'+vo.nff+'</nffStep><turnaroundStep>'+vo.turnaround+'</turnaroundStep><sparesBought>'+vo.spares+'</sparesBought></requestParams>';
			statusUpdate.dispatch("submitting to socket server......"+xmlStr);
			
			_timer = new Timer(400, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, dummyComplete);
			_timer.start();
			startWaitTimer(true);
			
		}
		
		public function init():void{
			
			_attempts = 0;
			initResubmission();
			
			//return  //- only uncomment when testing without blackbox
			statusUpdate.dispatch("connecting to socket on ip:"+_ip+"  port:"+_port);
			
			//create socket connection
			_socket = new CustomSocket(_ip, Number(_port));
			//add listener for data
			_socket.messageSender.addEventListener(_socket.NEW_MSG, myListener);
			_socket.messageSender.addEventListener(_socket.CONNECTEDUP, connectedList);
			_socket.messageSender.addEventListener(SocketEvent.ANY, socketTrace);
			_socket.messageSender.addEventListener(SocketEvent.ERROR, socketError);
			
		}
		
		private function cannotConnect( s:SocketEvent ):void{
			
			_attempts = 0;
			startWaitTimer(false);
			errorReceived.dispatch("There has been an error. Click to restart");
			disposeSocket();
			init();
			
		}
		
		private function disposeSocket():void{
			_socket.messageSender.removeEventListener(_socket.NEW_MSG, myListener);
			_socket.messageSender.removeEventListener(_socket.CONNECTEDUP, connectedList);
			_socket.messageSender.removeEventListener(SocketEvent.ANY, socketTrace);
			_socket = null;
		}
		
		private function startWaitTimer( b:Boolean ):void{
			if (b){
				if (!_checkReceived){
					_checkReceived = new Timer(_checkWait, 3);
					_checkReceived.addEventListener(TimerEvent.TIMER, notReceived);
					_checkReceived.start();
				}
			}else{
				_attempts = 0;
				if (!_checkReceived) return;
				_checkReceived.stop();
				_checkReceived.removeEventListener(TimerEvent.TIMER, notReceived);
				_checkReceived = null;
			}
		}
		
		private function notReceived( t:TimerEvent ):void{
			_attempts ++;	
			if (_attempts<MAX_ATTEMPTS){
			}else{
				_attempts = 0;
				startWaitTimer(false);
				errorReceived.dispatch("There has been an error. Click to restart");
				disposeSocket();
				init();
			}
		}
		
		
		private function connectedList(e:Event):void
		{
			statusUpdate.dispatch("SOCKET SONNECTED IN BLACK BOX");
			
		}
		
		private function myListener(e:Event):void
		{
			statusUpdate.dispatch("NEW MSG IN black box:"+_socket.responseMsg);
			dataReceived(_socket.responseMsg);
		}
		
		private function socketTrace( e:SocketEvent ):void{
			
				if (e.msg== SocketEvent.ERROR){
				_attempts = 0;
				startWaitTimer(false);
				errorReceived.dispatch("Black box is not running. Restart both applications");
			}else{
				statusUpdate.dispatch(e.msg);
			}
		}
		
		
		private function socketError( c:CustomEvent ):void{
			
			statusUpdate.dispatch(c.type+"--------UNABLE TO CONNECT TO SOCKET, retrying..."+_attempts);
			startWaitTimer(true);
			
		}
		
		private function resubmit( e:TimerEvent ):void{
			
			sendData(_tempSubmitVO);
		}
		
		//used to initialise the mechanism to resubmit reponses if an error is received
		private function initResubmission():void{
			_resubmitTimer = new Timer(500, 1);
			_resubmitTimer.addEventListener(TimerEvent.TIMER_COMPLETE, resubmit);
		}
		
		
		public function sendData( vo:InputVO ):void{
			_tempSubmitVO = vo;
			_iteration = Number(vo.iteration);
			
			var xmlStr:String = '<?xml version="1.0" encoding="UTF-8" ?><requestParams><gameID>'+vo.gameID+'</gameID><iteration>'+vo.iteration+'</iteration><reliabilityStep>'+vo.reliability+'</reliabilityStep><nffStep>'+vo.nff+'</nffStep><turnaroundStep>'+vo.turnaround+'</turnaroundStep><sparesBought>'+vo.spares+'</sparesBought></requestParams>';
			xmlStr = "";
			var sendStr:String = xmlStr.concat('<requestParams><gameID>'+vo.gameID+'</gameID><iteration>'+vo.iteration+'</iteration><reliabilityStep>'+vo.reliability+'</reliabilityStep><nffStep>'+vo.nff+'</nffStep><turnaroundStep>'+vo.turnaround+'</turnaroundStep><sparesBought>'+vo.spares+'</sparesBought></requestParams>');
			
			statusUpdate.dispatch("submitting to socket server......:"+sendStr+":");
			
			startWaitTimer(false);
			_socket.write(sendStr);
			
		}
		
		private function timerLister( e:TimerEvent ):void{
			_sendTimer.stop();
			_sendTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerLister);
			_sendTimer = null;
			statusUpdate.dispatch("TIMER COMPLETE");
			_socket.write(_storedSendString);
			
		}	
		private function connectedListener( e:Event ):void{
			
			statusUpdate.dispatch( "!connected to the socket server");
			_timer.stop();
			
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
			var xml:XML = new XML(s);
			//check if this is an error and retry 3 times
			if(xml.name() == "errors"){
				if (_attempts < MAX_ATTEMPTS){
					_attempts ++;
					//resubmit
					trace("resubmitting");
					_resubmitTimer.start();
					
					
				}else{
					//send signal to show error
					var msg:String = "There has been an error. Click to restart";
					if (xml.@desc){
						if (xml.desc.length>0){
							msg = xml.@desc;
						}
					}
					errorReceived.dispatch(msg);
					disposeSocket();
					init();
				}
			}else{
				startWaitTimer(false);
				bBDataReceived.dispatch(xml);
			}
			
		}
	}
}