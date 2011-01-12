package services
{
	
	
	import model.LeaderBoardModel;
	import model.vo.ErrorVO;
	import model.vo.LeaderBoardVO;
	import model.vo.UserVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.http.HTTPService;
	
	import org.robotlegs.mvcs.Actor;
	
	import signals.ErrorReceived;
	
	public class LeaderBoardService extends Actor
	{
		[Inject]
		public var lbModel:LeaderBoardModel;
		[Inject]
		public var errorReceived:ErrorReceived;
		
		private var _xmlFile:String = "data/winners.xml";
		
		
		public function requestData():void
		{
			//todo swap out to use flash vars instead
			trace("loading leaderboard....");
			//loads xml
			var service:HTTPService = new HTTPService();
			var responder:mx.rpc.Responder = new Responder(handleServiceResult, handleServiceFault);
			var token:AsyncToken;
			service.resultFormat = "e4x";
			service.url = _xmlFile;
			token = service.send();
			token.addResponder(responder);
		}
		
		private function handleServiceResult(event:Object):void{
			trace("leader board data received");
			
			var xml:XML = event.result as XML;
			var winnersList:XMLList = xml.user;
			var vo:LeaderBoardVO = new LeaderBoardVO();
			var winners:Array = [];
			//TODO add params here
			for(var i:uint = 0; i< winnersList.length(); i++){
				var user:XML = winnersList[i];
				var userVO:UserVO = new UserVO();
				userVO.label = user.@name;
				userVO.score = Number(user.@score);
				winners[i] = userVO;
			}
			vo.winners = new ArrayCollection(winners);
			
			//set the vo on the model
			lbModel.vo = vo;
			
		}
		
		private function handleServiceFault(event:Object):void{
			trace("xml error in loading, dispatching error signal");
			var vo:ErrorVO = new ErrorVO();
			vo.title = "XML Load Error";
			vo.msg = "There has been an error loading the leader board, please click OK to attempt load again";
			vo.fn = "reloadLeaderBoard";
			errorReceived.dispatch(vo);
		}
		
		//returns the position on the leaderboard of the user, -1 means they are not on the board
		public function returnWinnersPosition( vo:UserVO ):int{
			
			var retI:int = -1;
			//todo calculate position on the leaderboard
			return retI;
		}
		
		public function setNewWinner( vo:UserVO ):void{
			
			//find out where the new user should be placed
			var insert:int = returnWinnersPosition(vo);
			var lBVO:LeaderBoardVO = lbModel.vo;
			//lBVO.winners.splice( insert, 1, vo );
			lbModel.vo = lBVO;
			
		}
	}
}