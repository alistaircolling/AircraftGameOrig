package view.mediators
{
	import flash.events.MouseEvent;
	
	import model.UserDataModel;
	import model.vo.LeaderBoardVO;
	import model.vo.ReceivedDataVO;
	import model.vo.UserVO;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.ChangeState;
	import signals.EnterWinner;
	import signals.LeaderBoardSet;
	import signals.RequestLeaderBoard;
	import signals.UserDataSet;
	
	import view.components.FinalView;
	
	public class FinalViewMediator extends Mediator
	{
		[Inject]
		public var finalView:FinalView;
		[Inject]
		public var changeState:ChangeState;
		[Inject]
		public var userDataSet:UserDataSet;
		[Inject]
		public var leaderBoardSet:LeaderBoardSet;
		[Inject]
		public var requestLeaderBoard:RequestLeaderBoard;
		[Inject]
		public var userModel:UserDataModel;
		[Inject]
		public var enterWinner:EnterWinner;
		
		private var _boardPosition:int;
		
		override public function onRegister():void{
			
			trace("finalview registered");
			finalView.continueBtn.addEventListener(MouseEvent.CLICK, continueClicked);
			userDataSet.add(setData);
			leaderBoardSet.add(setLeaderBoard);
			requestLeaderBoard.dispatch();
		}
		
		override public function onRemove():void{
			
			trace("finalview unregistered");
			finalView.continueBtn.removeEventListener(MouseEvent.CLICK, continueClicked);
			userDataSet.remove(setData);
			leaderBoardSet.remove(setLeaderBoard);
		}
		
		private function setLeaderBoard( vo:LeaderBoardVO ):void{
			
			finalView.leaderBoard.dp = vo.winners;
		}
		
		private function setData( vo:ReceivedDataVO):void{
			
			//check to see this is the last iteration
			if (vo.iteration == 3){
				//set the availability and the cost
				finalView.availability.text = "Availability: "+vo.avAvailability.toString();
				finalView.cost.text = "£"+vo.finalScore; 
				
				//check if the user has a high score
				_boardPosition = -1;
				var winners:ArrayCollection = finalView.leaderBoard.dp;
				for (var i:int = winners.length-1; i>=0 ; i--){
					var uVO:UserVO = winners[i] as UserVO;
					var winVal:Number = uVO.score;
					if(vo.finalScore > winVal){
						_boardPosition = i;
					} 
				}
				if (_boardPosition>-1){
					showEnterDetails(true);
					trace(" we have a winner !!!!!  at pos:"+_boardPosition);
				}else{
					showEnterDetails(false);
				}
			}
			//clear entry field
			finalView.enterName.text = "";
			
		}
		
		private function showEnterDetails(b:Boolean):void{
			
			if(b){
				finalView.message.text = "Congratulations, you made the leader board. Please enter you initial below";
			 	finalView.enterName.visible = true;
			}else{
				finalView.message.text = "";
			 	finalView.enterName.visible = false;
			}
			
		}
		
	
		private function continueClicked( m:MouseEvent ):void{
			trace("-------continue clicked");
			
			enterWinner.dispatch(finalView.enterName.text, _boardPosition);
			changeState.dispatch(ChangeState.EXIT_SCREEN);
			
		}
	}
}