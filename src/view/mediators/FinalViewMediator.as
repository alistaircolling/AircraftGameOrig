package view.mediators
{
	import events.UpdateLetterEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.UserDataModel;
	import model.vo.LeaderBoardVO;
	import model.vo.ReceivedDataVO;
	import model.vo.UserVO;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.ChangeState;
	import signals.EnterWinner;
	import signals.ForceShowHighlight;
	import signals.GameTypeSet;
	import signals.LeaderBoardSet;
	import signals.RequestLeaderBoard;
	import signals.RestartGame;
	import signals.ShowWinnerHighlight;
	import signals.UpdateWinner;
	import signals.UserDataSet;
	
	import utils.StringUtils;
	
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
		[Inject]
		public var updateWinner:UpdateWinner;
		[Inject]
		public var restartGame:RestartGame;
		[Inject]
		public var showWinnerHighlight:ShowWinnerHighlight; 
		[Inject]
		public var gameTypeSet:GameTypeSet;
		[Inject]
		public var forceHighlight:ForceShowHighlight;
		
		private var _boardPosition:int;
		private var _success:String = "Congratulations, you have made the leader board." +
			" Please enter your initials below."
		private var _failure:String = "";//Well done! You didn't make the leader board unfortunately."  
		private var _winnerName:String;
		private var _score:Number;
		
		override public function onRegister():void{
			
			trace("finalview registered");
			finalView.continueBtn.addEventListener(MouseEvent.CLICK, continueClicked);
			userDataSet.add(setData);
			leaderBoardSet.add(setLeaderBoard);
			forceHighlight.add(showWinnerHlight);
			gameTypeSet.add(onGameTypeSet);
			requestLeaderBoard.dispatch();
			finalView.lS1.addEventListener(UpdateLetterEvent.LETTER_CHANGED, letterChangedListener);
			finalView.lS2.addEventListener(UpdateLetterEvent.LETTER_CHANGED, letterChangedListener);
			finalView.lS3.addEventListener(UpdateLetterEvent.LETTER_CHANGED, letterChangedListener);
			onGameTypeSet(userModel.gameType);
		}
		
		override public function onRemove():void{
			
			trace("finalview unregistered");
			finalView.continueBtn.removeEventListener(MouseEvent.CLICK, continueClicked);
			userDataSet.remove(setData);
			forceHighlight.remove(showWinnerHlight);
			gameTypeSet.remove(onGameTypeSet);
			leaderBoardSet.remove(setLeaderBoard);
			finalView.lS1.removeEventListener(UpdateLetterEvent.LETTER_CHANGED, letterChangedListener);
			finalView.lS2.removeEventListener(UpdateLetterEvent.LETTER_CHANGED, letterChangedListener);
			finalView.lS3.removeEventListener(UpdateLetterEvent.LETTER_CHANGED, letterChangedListener);
		}
		
		private function onGameTypeSet(s:String):void{
			switch(s){
				case "plane":
					finalView.planePanel.visible = true;
					finalView.heliPanel.visible = false;
					break
				case "heli":
					finalView.planePanel.visible = false;
					finalView.heliPanel.visible = true;
					break
			}	
		}
		
		//triggered when we enter the final screen
		public function showWinnerHlight():void{
			if (_boardPosition>-1){//only show if there is a position
				letterChangedListener(null, true);
			}
			
		}
		
		private function letterChangedListener( e:UpdateLetterEvent  = null, initial:Boolean = false):void{
			
			_winnerName = getWinnerName();
			trace("name is now:"+_winnerName);
			var vo:UserVO = new UserVO();
			vo.label = _winnerName;
			vo.score = _score;
			vo.highlight = true;
			updateWinner.dispatch(vo, _boardPosition, initial);
		}
		
		private function getWinnerName():String{
			return finalView.lS1.currentLetter+finalView.lS2.currentLetter+finalView.lS3.currentLetter;
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
				
				//format strings for negative budget
				var budgetString:String = vo.finalScore.toString();
				//returns true if a minus exists
				if (StringUtils.hasMinus(budgetString)){
					finalView.negativeLabel.text = "-";
					budgetString = budgetString.slice(1);
				}else{
					finalView.negativeLabel.text = "";
				}
				
				finalView.finalScore.text = budgetString+"m"; 
				_score = vo.finalScore;
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
				//create a new winners list with a blank winner containing only the score and the default letters
				
				if (_boardPosition>-1){
					showEnterDetails(true);
					trace(" we have a winner !!!!!  at pos:"+_boardPosition);
					//dispatch init event to show highlight
					//letterChangedListener(null, true);
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
			}else{
				finalView.message.text = _failure;
				finalView.enterInitials.visible = false;
			}
		}
		
		
		private function continueClicked( m:MouseEvent ):void{
			
			trace("-------continue clicked");
			if (_boardPosition>-1){
				
				var winnerInitials:String = getWinnerName();
				enterWinner.dispatch();
			}
			
			trace("--restart clicked");
			restartGame.dispatch();
			
		}
	}
}