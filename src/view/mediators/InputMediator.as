package view.mediators
{
	import events.NumberEvent;
	
	import flash.events.MouseEvent;
	
	import model.UserDataModel;
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
		[Inject]
		public var userModel:UserDataModel;//used only to get the current iteration for submission in vo
		
		override public function onRegister():void{
			trace("Input Mediator Registered");
			userDataSet.add(setData);	
			balanceSet.add(showBalance);
			iterationChange.add(updateIteration);
			//leaderboardSet.add(updateLeaderBoard);
			inputView.addEventListener(NumberEvent.BALANCE_UPDATE, updateBalance);//event triggered by steppers
			inputView.inputPanel.submit.addEventListener(MouseEvent.CLICK, goClicked);
			
		}
		
		override public function onRemove():void{
			
			userDataSet.remove(setData);	
			balanceSet.remove(showBalance);
			iterationChange.remove(updateIteration);
			//leaderboardSet.remove(updateLeaderBoard);
			inputView.removeEventListener(NumberEvent.BALANCE_UPDATE, updateBalance);//event triggered by steppers
			inputView.inputPanel.submit.removeEventListener(MouseEvent.CLICK, goClicked);
			
		}
		
		private function goClicked( m:MouseEvent ):void{
			
			//increase iteration first so it is correct for submission
			
			
			//create a new VO
			var vo:InputVO = new InputVO();
			vo.nff = inputView.inputPanel.nff.currVal.theIndex.toString();
			vo.turnaround = inputView.inputPanel.turnaround.currVal.theIndex.toString();
			vo.reliability = inputView.inputPanel.reliability.currVal.theIndex.toString();
			vo.spares = (inputView.inputPanel.spares.sparesCurr - inputView.inputPanel.spares.sparesInit).toString();
			var it:uint = userModel.iteration;
			it++; //avoid updating the iteration on the model directly so a new iteration signal is not sent, this is set by the black box when data is returned anyway
			vo.iteration = (it).toString();
			dataSubmitted.dispatch(vo);
			
		}
		
		private function updateIteration( n:uint ):void{
			n++;
			inputView.inputPanel.turn.text = "(Turn "+n.toString()+" of 3)";
		}
		
	/*	private function updateLeaderBoard( vo:LeaderBoardVO ):void{
			
			var top3:Array = vo.winners.source.slice(0,3);
			var ac:ArrayCollection = new ArrayCollection(top3);
			inputView.leaderBoard.dp = ac;
			
		}*/
		
		private function showBalance( n:Number ):void{
			
			inputView.showBalance(n);
		}
		
		
		//user has updated the balance
		private function updateBalance( n:NumberEvent ):void{
			
			//updateBal.dispatch(n.value);  only updates the view component now
			var currBal:Number = inputView.inputPanel.budget;
			var newBal:Number = currBal+n.value;
			inputView.inputPanel.budget = Math.round(newBal*100)/100;
			//update balance in spares
			inputView.inputPanel.spares.budget = inputView.inputPanel.budget;
			
		}
		
		private function setData( vo:ReceivedDataVO ):void{
			
			inputView.setData(vo);
			
		}
	}
}