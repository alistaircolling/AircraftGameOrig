package view.mediators
{
	import events.ChangeStateEvent;
	import events.PlanesEvent;
	
	import flash.events.Event;
	
	import model.vo.GraphResultsVO;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.ChangeState;
	import signals.GraphDataSet;
	import signals.IterationChange;
	
	import view.components.GraphComponent;
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
		
		private var _animating:Boolean;
		
		override public function onRegister():void{
			
			graphDataSet.add(setData);
			resultsView.graph.reset();
			iterationChange.add(setIteration);
			resultsView.addEventListener(ChangeState.ENTER_SCREEN, changeState);
			changeStateSignal.add(updateState);
			resultsView.graph.addEventListener(PlanesEvent.IN_AIR, updateInAir);
			resultsView.graph.addEventListener(PlanesEvent.ON_GROUND, updateOnGround);
			resultsView.graph.addEventListener(GraphComponent.FINISHED_ANIMATING, finishedAnimating);
		}
		private function finishedAnimating( e:Event):void{
			trace("finished animating");
			_animating = false;
		}
		
		private function updateInAir( e:PlanesEvent ):void{
			resultsView.showInAir( e.num );
		}
		
		private function updateOnGround( e:PlanesEvent ):void{
			
			resultsView.showOnGround( e.num );
		}
		
		
		private function updateState( s:String ):void{
			
			//triggered when going back to the start --  clear  the graph
			if (s == ChangeState.INTRO_SCREEN){
				
				resultsView.graph.reset();
			}
		}
		
		override public function onRemove():void{
			graphDataSet.remove(setData);
			iterationChange.remove(setIteration);
			resultsView.removeEventListener(ChangeState.ENTER_SCREEN, changeState);
			changeStateSignal.remove(updateState);
			resultsView.graph.removeEventListener(PlanesEvent.IN_AIR, updateInAir);
			resultsView.graph.removeEventListener(PlanesEvent.ON_GROUND, updateOnGround);
			resultsView.graph.removeEventListener(GraphComponent.FINISHED_ANIMATING, finishedAnimating);
		}
		
		private function changeState( e:ChangeStateEvent ):void{
			if (!_animating){
				
				changeStateSignal.dispatch(e.state);
				
			}else{
				
				trace("unable to change sections as animating");
				
			}
			
		}
		
		private function setIteration( n:uint ):void{
			
			resultsView.iteration = n;
			
		}
		
		private function setData( vo:GraphResultsVO ):void{
			
			_animating = true;
			resultsView.setData(vo);
			
		}
	}
}