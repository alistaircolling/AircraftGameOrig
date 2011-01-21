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
		public var restartGame:RestartGame;
		
		override public function onRegister():void{
			
			exitView.addEventListener("restartGame", restartGameListener);
		}
		
		override public function onRemove():void{
			
			exitView.removeEventListener("restartGame", restartGameListener);
		}
		
		private function restartGameListener( m:Event ):void{
			
			restartGame.dispatch();
		}
		
	}
}