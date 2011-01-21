package view.mediators
{
	import flash.events.MouseEvent;
	
	import model.vo.LeaderBoardVO;
	import model.vo.ReceivedDataVO;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.ChangeState;
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
		
		
		override public function onRegister():void{
			
			trace("finalview registered");
			finalView.continueBtn.addEventListener(MouseEvent.CLICK, continueClicked);
			userDataSet.add(setData);
			leaderBoardSet.add(setLeaderBoard);
			requestLeaderBoard.dispatch();
		}
		
		override public function onRemove():void{
			
			trace("finalview registered");
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
				finalView.cost.text = "£"+vo.cost;//temorarily set to budget--checking 
				
			}
			
		}
		
		private function continueClicked( m:MouseEvent ):void{
			trace("continue clicked");
			changeState.dispatch(ChangeState.EXIT_SCREEN);
			
		}
	}
}