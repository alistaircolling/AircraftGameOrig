package view.mediators
{
	import flash.events.MouseEvent;
	
	import model.vo.LeaderBoardVO;
	import model.vo.UserVO;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.LeaderBoardSet;
	import signals.StartClicked;
	import signals.TextSetOnModel;
	
	import view.components.IntroView;
	
	public class IntroMediator extends Mediator
	{
		[Inject]
		public var introView:IntroView;
		[Inject]
		public var startClicked:StartClicked;
		[Inject]
		public var textSetOnModel:TextSetOnModel;
		[Inject]
		public var leaderBoardSet:LeaderBoardSet;
		
		
		override public function onRegister():void{
			trace("Intro Mediator registered");
			//register listeners 
			addListeners();
		}
		
		private function addListeners():void{
			
			introView.start.addEventListener(MouseEvent.CLICK, buttonClickedListener);
			
			//add listener for signal
			textSetOnModel.add(onModelChanged);
			leaderBoardSet.add(updateLeaderBoard);
		}
		
		private function updateLeaderBoard( vo:LeaderBoardVO ):void{
			
			introView.leaderboardIntro.dp = vo.winners;
			
		}
		
		//be sure to pass the corect data type of the signal
		public function onModelChanged(__s:String):void{
			
		//	(viewComponent as IntroView).textA.text = __s;
			
		}
		
		private function buttonClickedListener(__m:MouseEvent):void{ 
			
			//get data from this box
			
		//	var __s:String = (viewComponent as IntroView).textA.text 	
			
			//send signal
			startClicked.dispatch();
			
		}
	}
}