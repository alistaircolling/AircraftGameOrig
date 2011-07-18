package view.mediators
{
	import flash.events.MouseEvent;
	
	import model.vo.LeaderBoardVO;
	import model.vo.UserVO;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	import signals.GameTypeSelected;
	import signals.LeaderBoardSet;
	import signals.LoadXML;
	import signals.StartClicked;
	import signals.StatusUpdate;
	import signals.TextSetOnModel;
	import signals.WaitSetByXML;
	
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
		[Inject]
		public var loadXML:LoadXML;
		[Inject]
		public var update:StatusUpdate;
		[Inject]
		public var gameTypeSelected:GameTypeSelected;
		[Inject]
		public var waitSet:WaitSetByXML;
		
		override public function onRegister():void{
			trace("Intro Mediator registered");
			update.dispatch("Intro mediator registered");
			//register listeners 
			addListeners();
			//
			loadXML.dispatch();
		}
		
		override public function onRemove():void{
			
			introView.planeButton.removeEventListener(MouseEvent.CLICK, planeClicked);
			introView.heliButton.removeEventListener(MouseEvent.CLICK, heliClicked);
			introView.continueButton.removeEventListener(MouseEvent.CLICK, videoContinueClicked);
			//add listener for signal
			textSetOnModel.add(onModelChanged);
			leaderBoardSet.add(updateLeaderBoard);
			waitSet.remove(onWaitSet);
			
		}
		
		private function addListeners():void{
			trace("add intro mediator listeners");
			waitSet.add(onWaitSet);
			introView.continueButton.addEventListener(MouseEvent.CLICK, videoContinueClicked);
			introView.planeButton.addEventListener(MouseEvent.CLICK, planeClicked);
			introView.heliButton.addEventListener(MouseEvent.CLICK, heliClicked);
			
			//add listener for signal
			textSetOnModel.add(onModelChanged);
			leaderBoardSet.add(updateLeaderBoard);
		}
		//milliseconds wait set
		private function onWaitSet(n:int):void{
			introView.interactionWait = n;
			
		}
		private function videoContinueClicked( m:MouseEvent ):void{
			
			introView.showVideo(false);		
			introView.startTimer(true);
		}
		private function updateLeaderBoard( vo:LeaderBoardVO ):void{
			introView.leaderboardIntro.dp = vo.winners;
		}
		
		//be sure to pass the corect data type of the signal
		public function onModelChanged(__s:String):void{
			
			
		}
		
		private function planeClicked( m:MouseEvent ):void{
				introView.startTimer(false);
				gameTypeSelected.dispatch("plane");
				startClicked.dispatch();
		}
		private function heliClicked( m:MouseEvent ):void{
				introView.startTimer(false);
				gameTypeSelected.dispatch("heli");
				startClicked.dispatch();
		}
		
	
	}
}