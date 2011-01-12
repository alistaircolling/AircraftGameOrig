package view.mediators
{
	import model.vo.InputDataVO;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.UserDataSet;
	
	import view.components.InputView;
	
	public class InputMediator extends Mediator
	{
		[Inject]
		public var inputView:InputView;
		[Inject]
		public var userDataSet:UserDataSet;
		
		override public function onRegister():void{
			trace("Input Mediator Registered");
			userDataSet.add(setData);	
			
		}
		
		private function setData( vo:InputDataVO ):void{
			
			inputView.setData(vo);
			
		}
	}
}