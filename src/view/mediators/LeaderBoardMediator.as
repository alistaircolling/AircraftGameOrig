package view.mediators
{
	import model.vo.LeaderBoardVO;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.LeaderBoardSet;
	
	import view.components.LeaderBoard;
	
	public class LeaderBoardMediator extends Mediator
	{
		[Inject]
		public var view:LeaderBoard;
		[Inject]
		public var lbSet:LeaderBoardSet;
		
	
		override public function onRegister():void{
			
			lbSet.add(dataSet);
			
		}

		override public function onRemove():void{
			
			lbSet.remove(dataSet);
			
		}
		
		private function dataSet( vo:LeaderBoardVO ):void{
			
			view.dp  = vo.winners;
			
		}
	}
}