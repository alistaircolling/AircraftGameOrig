package view.mediators
{
	import org.robotlegs.mvcs.Mediator;
	
	import view.components.FinalView;
	
	public class FinalViewMediator extends Mediator
	{
		[Inject]
		public var finalView:FinalView;
		
		
		
		override public function onRegister():void{
			
			trace("finalview registered");
		}
	}
}