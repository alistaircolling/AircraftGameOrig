package view.mediators
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.ChangeState;
	import signals.RestartGame;
	
	import view.components.ExitView;
	
	public class ExitMediator extends Mediator
	{
		[Inject]
		public var exitView:ExitView;
		[Inject]
		public var changeState:ChangeState;
		
		override public function onRegister():void{
			
			exitView.continueButton.addEventListener(MouseEvent.CLICK, continueClickedListener);
		}
		
		override public function onRemove():void{
			exitView.continueButton.removeEventListener(MouseEvent.CLICK, continueClickedListener);
		}
		
		private function continueClickedListener( m:MouseEvent):void{
			exitView.userLeft();
			changeState.dispatch(ChangeState.FINAL_SCREEN);
		}
		
		
	}
}