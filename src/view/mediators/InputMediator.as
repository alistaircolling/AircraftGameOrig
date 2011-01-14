package view.mediators
{
	import events.NumberEvent;
	
	import model.vo.InputDataVO;
	
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
			
		}
		
		private function showBalance( n:Number ):void{
			
			inputView.showBalance(n);
		}
		
		
		//user has updated the balance
		private function updateBalance( n:NumberEvent ):void{
			
			updateBal.dispatch(n.value);
			
		}
		
		private function setData( vo:InputDataVO ):void{
			
			inputView.setData(vo);
			
		}
	}
}