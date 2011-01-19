package view.mediators
{
	import events.NumberEvent;
	
	import flash.events.MouseEvent;
	
	import model.vo.InputVO;
	import model.vo.LeaderBoardVO;
	import model.vo.ReceivedDataVO;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.BalanceSet;
	import signals.DataSubmitted;
	import signals.IterationChange;
	import signals.LeaderBoardSet;
	import signals.UpdateBalance;
	import signals.UserDataSet;
	
	import view.components.InputView;
	
	public class InputMediator extends Mediator
	{
		[Inject]
		public var inputView:InputView;
		[Inject]
		public var userDataSet:UserDataSet;
		[Inject]
		public var updateBal:UpdateBalance;//updated by user
		[Inject]
		public var balanceSet:BalanceSet;//set in the model
		[Inject]
		public var leaderboardSet:LeaderBoardSet;
		[Inject]
		public var iterationChange:IterationChange;
		[Inject]
		public var dataSubmitted:DataSubmitted;
		
		override public function onRegister():void{
			trace("Input Mediator Registered");
			userDataSet.add(setData);	
			balanceSet.add(showBalance);
			iterationChange.add(updateIteration);
			leaderboardSet.add(updateLeaderBoard);
			inputView.addEventListener(NumberEvent.BALANCE_UPDATE, updateBalance);//event triggered by steppers
			inputView.inputPanel.submit.addEventListener(MouseEvent.CLICK, goClicked);
			
		}
		
		private function goClicked( m:MouseEvent ):void{
			
			//create a new VO
			var vo:InputVO = new InputVO();
			vo.nff = inputView.inputPanel.nff.currVal.theIndex.toString();
			//vo.spares = inputView.inputPanel.spares.currVal.theIndex;
			vo.turnaround = inputView.inputPanel.turnaround.currVal.theIndex.toString();
			vo.reliability = inputView.inputPanel.reliability.currVal.theIndex.toString();
			vo.spares = (inputView.inputPanel.spares.sparesCurr - inputView.inputPanel.spares.sparesInit).toString();
			dataSubmitted.dispatch(vo);
			
		}
		
		private function updateIteration( n:uint ):void{
			
			inputView.inputPanel.turn.text = "(Turn "+n.toString()+" of 3)";
		}
		
		private function updateLeaderBoard( vo:LeaderBoardVO ):void{
			
			var top3:Array = vo.winners.source.slice(0,3);
			var ac:ArrayCollection = new ArrayCollection(top3);
			inputView.leaderBoard.dp = ac;
			
		}
		
		private function showBalance( n:Number ):void{
			
			inputView.showBalance(n);
		}
		
		
		//user has updated the balance
		private function updateBalance( n:NumberEvent ):void{
			
			//updateBal.dispatch(n.value);  only updates the view component now
			var currBal:Number = inputView.inputPanel.budget;
			var newBal:Number = currBal+n.value;
			inputView.inputPanel.budget = Math.round(newBal*100)/100;
			
		}
		
		private function setData( vo:ReceivedDataVO ):void{
			
			inputView.setData(vo);
			
		}
	}
}