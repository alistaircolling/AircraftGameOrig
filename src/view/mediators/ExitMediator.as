package view.mediators
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import model.UserDataModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.ChangeState;
	import signals.ForceShowHighlight;
	import signals.GameTypeSet;
	import signals.RestartGame;
	
	import view.components.ExitView;
	
	public class ExitMediator extends Mediator
	{
		[Inject]
		public var exitView:ExitView;
		[Inject]
		public var changeState:ChangeState;
		[Inject]
		public var gameTypeSet:GameTypeSet;
		[Inject]
		public var userModel:UserDataModel;
		[Inject]
		public var forceHighlight:ForceShowHighlight;
		
		override public function onRegister():void{
			
			exitView.continueButton.addEventListener(MouseEvent.CLICK, continueClickedListener);
			gameTypeSet.add(onGameTypeSet);
			onGameTypeSet(userModel.gameType);
		}
		
		override public function onRemove():void{
			exitView.continueButton.removeEventListener(MouseEvent.CLICK, continueClickedListener);
			gameTypeSet.remove(onGameTypeSet);
		}
		
		private function onGameTypeSet(s:String):void{
			switch(s){
				case "plane":
					exitView.planePanel.visible = true;
					exitView.heliPanel.visible = false;
					break
				case "heli":
					exitView.planePanel.visible = false;
					exitView.heliPanel.visible = true;
					break
			}	
		}
		
		private function continueClickedListener( m:MouseEvent):void{
			exitView.userLeft();
			changeState.dispatch(ChangeState.FINAL_SCREEN);
			forceHighlight.dispatch();
		}
		
		
	}
}