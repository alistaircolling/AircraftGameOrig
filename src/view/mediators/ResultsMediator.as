package view.mediators
{
	import events.ChangeStateEvent;
	
	import model.vo.GraphResultsVO;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.ChangeState;
	import signals.GraphDataSet;
	import signals.IterationChange;
	
	import view.components.ResultsView;
	
	public class ResultsMediator extends Mediator
	{
		[Inject]
		public var resultsView:ResultsView;
		[Inject]
		public var graphDataSet:GraphDataSet;
		[Inject]
		public var iterationChange:IterationChange;
		[Inject]
		public var changeStateSignal:ChangeState;
		
		override public function onRegister():void{
			
			graphDataSet.add(setData);
			iterationChange.add(setIteration);
			resultsView.addEventListener(ChangeState.ENTER_SCREEN, changeState);
		}
		
		override public function onRemove():void{
			
			trace("results mediator removed!!!");
		}
		
		private function changeState( e:ChangeStateEvent ):void{
			
			changeStateSignal.dispatch(e.state);
			
		}
		
		private function setIteration( n:uint ):void{
						
				resultsView.iteration = n;
			
		}
		
		private function setData( vo:GraphResultsVO ):void{
			
			resultsView.graph.setData(vo);
			
		}
	}
}