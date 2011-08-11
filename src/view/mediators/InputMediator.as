package view.mediators
{
	import events.NumberEvent;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import model.UserDataModel;
	import model.vo.InputVO;
	import model.vo.LeaderBoardVO;
	import model.vo.ReceivedDataVO;
	
	import mx.collections.ArrayCollection;
	
	import org.osmf.events.TimeEvent;
	import org.robotlegs.mvcs.Mediator;
	
	import signals.BalanceSet;
	import signals.DataSubmitted;
	import signals.IterationChange;
	import signals.LeaderBoardSet;
	import signals.StatusUpdate;
	import signals.UserDataSetLive;
	import signals.UpdateBalance;
	import signals.UserDataSet;
	
	import view.components.InputPanel;
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
		[Inject]
		public var statusUpdate:StatusUpdate;
		[Inject]
		public var userDataLiveSet:UserDataSetLive;
		
		
		private var _showTurnTimer:Timer
		private var _showBalanceTimer:Timer
		private var _showDataTimer:Timer
		private static const _showTurnWait:uint = 5000; 
		private var _iteration:uint;
		private var _data:ReceivedDataVO;
		private var _balance:Number;
		
		override public function onRegister():void{
			trace("===== input mediator registered ===== ");
			statusUpdate.dispatch("===== input mediator registered ===== ");
			balanceSet.add(showBalance);
			iterationChange.add(updateIteration);
			userDataLiveSet.add(liveDataReceived);
			inputView.addEventListener(NumberEvent.BALANCE_UPDATE, updateBalance);//event triggered by steppers
			inputView.inputPanel.submit.addEventListener(MouseEvent.CLICK, goClicked);
			
		}
		
		override public function onRemove():void{
			userDataLiveSet.add(liveDataReceived);
			trace("===== input mediator removed ===== ");
			statusUpdate.dispatch("===== input mediator removed ===== ");
			userDataLiveSet.remove(liveDataReceived);
			balanceSet.remove(showBalance);
			iterationChange.remove(updateIteration);
			inputView.removeEventListener(NumberEvent.BALANCE_UPDATE, updateBalance);//event triggered by steppers
			inputView.inputPanel.submit.removeEventListener(MouseEvent.CLICK, goClicked);
			
		}
		private function liveDataReceived( vo:ReceivedDataVO ):void{
			trace("==== === === === == == = = RECEVIVED VO ");
			//this fn is used as the userdataset command was not being heard and so a new signal was created 
			setData(vo);
		}
		
		private function goClicked( m:MouseEvent ):void{
			//increase iteration first so it is correct for submission
			statusUpdate.dispatch("> > > > > go clicked");
			//return;
			//create a new VO
			var vo:InputVO = new InputVO();
			vo.nff = inputView.inputPanel.nff.currVal.theIndex.toString();
			vo.turnaround = inputView.inputPanel.turnaround.currVal.theIndex.toString();
			vo.reliability = inputView.inputPanel.reliability.currVal.theIndex.toString();
			vo.spares = (inputView.inputPanel.spares.sparesCurr - inputView.inputPanel.spares.sparesInit).toString();
			trace("SPARES SUBMITTED:"+vo.spares);
			var it:uint = userModel.iteration;
			it++; //avoid updating the iteration on the model directly so a new iteration signal is not sent, this is set by the black box when data is returned anyway
			vo.iteration = (it).toString();
			statusUpdate.dispatch("vo created about to be submitted....");
			
			dataSubmitted.dispatch(vo);
		}
		
		private function updateIteration( n:uint ):void{
			n++;
			_iteration = n;
			if (n==1){
				showTurn();
			}else{
				_showTurnTimer = new Timer(_showTurnWait, 1);
				_showTurnTimer.addEventListener(TimerEvent.TIMER_COMPLETE, showTurn);
				_showTurnTimer.start();
			}
		}
		
		private function showTurn( t:TimerEvent = null ):void{
			inputView.inputPanel.showTurn(_iteration); 
			if (!_showTurnTimer) return;
			_showTurnTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, showTurn);
			_showTurnTimer = null;
		}
		
		private function showBalance( n:Number ):void{
			_balance = n;
			if(_iteration ==1){
				showBalanceReal();
			}else{
				_showBalanceTimer = new Timer(_showTurnWait, 1);
				_showBalanceTimer.addEventListener(TimerEvent.TIMER_COMPLETE, showBalanceReal);
				_showBalanceTimer.start();
			}
			
		}
		
		private function showBalanceReal( t:TimerEvent = null):void{
			inputView.showBalance(_balance);
			if (!_showBalanceTimer) return;
			_showBalanceTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, showTurn);
			_showBalanceTimer = null;
		}
		
		//user has updated the balance
		private function updateBalance( n:NumberEvent ):void{
			
			var currBal:Number = inputView.inputPanel.budget;
			var newBal:Number = currBal+n.value;
			
			//now set after the spares to override the spares automatically updating it		
			var newBudget:Number = Math.round(newBal*100)/100;
			
			//update balance in spares
			inputView.inputPanel.spares.budget = newBudget;//use new budget to the left  not>> inputView.inputPanel.budget;
			
			
			inputView.inputPanel.budget = newBudget;
			//update balance in other steppers
			
			inputView.inputPanel.nff.budget = newBudget;
			inputView.inputPanel.turnaround.budget = newBudget;
			inputView.inputPanel.reliability.budget = newBudget;
			
		}
		
		private function showDataReal(t:TimerEvent = null):void{
			inputView.setData(_data);
		}
		
		private function setData( vo:ReceivedDataVO ):void{
			trace("user data set heard in input mediator");
			_data = vo;
			_iteration = _data.iteration;
			if (_iteration==0){
				showDataReal();
			}else{
				_showDataTimer = new Timer(_showTurnWait, 1);
				_showDataTimer.addEventListener(TimerEvent.TIMER_COMPLETE, showDataReal);
				_showDataTimer.start();
			}
			
		}
	}
}