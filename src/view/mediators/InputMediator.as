package view.mediators
{
	import events.NumberEvent;
	
	import model.vo.InputDataVO;
	
	import org.robotlegs.mvcs.Mediator;
	
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
		public var updateBal:UpdateBalance;
		
		override public function onRegister():void{
			trace("Input Mediator Registered");
			userDataSet.add(setData);	
			inputView.addEventListener(NumberEvent.BALANCE_UPDATE, updateBalance);
			
		}
		
		private function updateBalance( n:NumberEvent ):void{
			
			updateBal.dispatch(n.value);
			
		}
		
		private function setData( vo:InputDataVO ):void{
			
			inputView.setData(vo);
			
		}
	}
}