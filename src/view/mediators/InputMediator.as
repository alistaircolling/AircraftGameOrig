package view.mediators
{
	import events.NumberEvent;
	
	import flash.events.MouseEvent;
	
	import model.vo.InputVO;
	import model.vo.ReceivedDataVO;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.BalanceSet;
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
		
		
		override public function onRegister():void{
			trace("Input Mediator Registered");
			userDataSet.add(setData);	
			balanceSet.add(showBalance);
			inputView.addEventListener(NumberEvent.BALANCE_UPDATE, updateBalance);
			inputView.inputPanel.submit.addEventListener(MouseEvent.CLICK, goClicked);
			
		}
		
		private function goClicked( m:MouseEvent ):void{
			
			//create a new VO
			var vo:InputVO = new InputVO();
			vo.nff = inputView.inputPanel.nff.currVal.theIndex;
			//vo.spares = inputView.inputPanel.spares.currVal.theIndex;
			vo.turnaround = inputView.inputPanel.turnaround.currVal.theIndex;
			vo.reliability = inputView.inputPanel.reliability.currVal.theIndex;
			vo.spares = inputView.inputPanel.spares.sparesCurr - inputView.inputPanel.spares.sparesInit; 
			
		}
		
		private function showBalance( n:Number ):void{
			
			inputView.showBalance(n);
		}
		
		
		//user has updated the balance
		private function updateBalance( n:NumberEvent ):void{
			
			updateBal.dispatch(n.value);
			
		}
		
		private function setData( vo:ReceivedDataVO ):void{
			
			inputView.setData(vo);
			
		}
	}
}