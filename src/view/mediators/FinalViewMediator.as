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
		private var _success:String = "Congratulations, you have made the leader board." +
			" Please enter your initials below."
		private var _failure:String = "";//Well done! You didn't make the leader board unfortunately."  
		
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
		
		private function resetSteppers():void{
			
			finalView.lS1.currentLetter = "A";
			finalView.lS2.currentLetter = "A";
			finalView.lS3.currentLetter = "A";
			finalView.lS1.letterIndex = 0;
			finalView.lS2.letterIndex = 0;
			finalView.lS3.letterIndex = 0;
			
		}
		
		private function setData( vo:ReceivedDataVO):void{
			resetSteppers()
			//check to see this is the last iteration
			if (vo.iteration == 3){
				//set the availability and the cost
				finalView.availability.text = vo.avAvailability.toString()+"%";
				finalView.cost.text = vo.costPerFHr.toString();
				finalView.finalScore.text = vo.finalScore.toString();
				
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
			
		}
		
		private function showEnterDetails(b:Boolean):void{
			
			if(b){
				finalView.message.text = _success;
				finalView.enterInitials.visible = true;
				//		finalView.message.text = "Congratulations, you made the leader board. Please enter you initial below";
				//	 	finalView.enterName.visible = true;	
			}else{
				finalView.message.text = _failure;
				finalView.enterInitials.visible = false;
				//	 	finalView.enterName.visible = false;
			}
			
		}
		
		
		private function continueClicked( m:MouseEvent ):void{
			trace("-------continue clicked");
			if (_boardPosition>-1){
				
				var winnerInitials:String = finalView.lS1.currentLetter+finalView.lS2.currentLetter+finalView.lS3.currentLetter;
				enterWinner.dispatch(winnerInitials, _boardPosition);
			}
			changeState.dispatch(ChangeState.EXIT_SCREEN);
			
		}
	}
}