package view.mediators
{
	import flash.events.MouseEvent;
	
	import model.vo.ErrorVO;
	
	import mx.controls.Alert;
	import mx.core.Application;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.ChangeState;
	import signals.ErrorReceived;
	import signals.StartClicked;
	import signals.StatusUpdate;
	import signals.TextSetOnModel;
	
	public class ProjectMediator extends Mediator
	{
		[Inject]
		public var viewComp:AircraftGame;
		[Inject]
		public var buttonClicked:StartClicked;
		[Inject]
		public var textSetOnModel:TextSetOnModel;
		[Inject]
		public var errorReceived:ErrorReceived;
		[Inject]
		public var changeState:ChangeState;
		[Inject]
		public var statusUpdate:StatusUpdate;
		
		override public function onRegister():void{
			trace("Project Mediator registered");
			//register listeners 
			addListeners();
		}
		
		private function addListeners():void {
			
			errorReceived.add(showError);
			changeState.add(updateState);
			statusUpdate.add(showStatus);
		//	mainViewComponent.btn.addEventListener(MouseEvent.CLICK, buttonClickedListener);
			//add listener for signal
		//	textSetOnModel.add(onModelChanged);
			
		}
		
		private function showStatus( s:String ):void{
			
			viewComp.statusLabel.text += "\n--------------\n"+s;
		}
		
		private function updateState( s:String ):void{
			
			viewComp.updateState(s);
		}
		
		private function errorClosed():void{
			
			trace("error closed");
			//todo add logic here to handle response depending on the sort of error
		}
		
		private function showError( vo:ErrorVO ):void{
			
			//todo add alert code here
			//todo possibly add a function / signal to be triggered when the user clicks ok,  depending on what the error message is
			Alert.show(vo.msg, vo.title, 4, viewComp,  errorClosed);
		}

		
		//be sure to pass the corect data type of 
		public function onModelChanged(__s:String):void{
			
			//mainViewComponent.tIn.text = __s;//update the view
			
		}
		
		
		private function buttonClickedListener(__m:MouseEvent):void { 
			
			//send signal
			buttonClicked.dispatch();
			
		}
		
	}
}