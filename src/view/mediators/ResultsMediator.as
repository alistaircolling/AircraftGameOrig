package view.mediators
{
	import model.vo.GraphResultsVO;
	
	import org.robotlegs.mvcs.Mediator;
	
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
		
		override public function onRegister():void{
			
			graphDataSet.add(setData);
			iterationChange.add(setIteration);
		}
		
		private function setIteration( n:uint ):void{
						
				resultsView.iteration = n;
			
		}
		
		private function setData( vo:GraphResultsVO ):void{
			
			resultsView.graph.setData(vo);
			
		}
	}
}