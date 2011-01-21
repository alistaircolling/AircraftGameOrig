package view.mediators
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.ChangeState;
	
	import view.components.FinalView;
	
	public class FinalViewMediator extends Mediator
	{
		[Inject]
		public var finalView:FinalView;
		[Inject]
		public var changeState:ChangeState;
		
		
		override public function onRegister():void{
			
			trace("finalview registered");
			finalView.continueBtn.addEventListener(MouseEvent.CLICK, continueClicked);
		}
		
		override public function onRemove():void{
			
			trace("finalview registered");
			finalView.continueBtn.removeEventListener(MouseEvent.CLICK, continueClicked);
		}
		
		private function continueClicked( m:MouseEvent ):void{
			trace("continue clicked");
			changeState.dispatch(ChangeState.EXIT_SCREEN);
			
		}
	}
}