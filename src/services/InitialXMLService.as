package services
{
	import model.UserDataModel;
	import model.vo.ErrorVO;
	import model.vo.ReceivedDataVO;
	import model.vo.InputObjectVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.http.HTTPService;
	
	import signals.ErrorReceived;

	public class InitialXMLService implements IXMLService
	{
		[Inject]
		public var userModel:UserDataModel;
		[Inject]
		public var errorReceived:ErrorReceived;
		
		public function loadXML(__s:String=null):void
		{
			var service:HTTPService = new HTTPService();
			var responder:mx.rpc.Responder = new Responder(handleServiceResult, handleServiceFault);
			var token:AsyncToken;
			service.resultFormat = "e4x";
			service.url = __s;
			token = service.send();
			token.addResponder(responder);
		}
		
		private function returnVectorFromList( xmlList:XML, initValue:Number ):Vector.<InputObjectVO>{
			
			//generate lookup tables
			var retVector:Vector.<InputObjectVO> = new Vector.<InputObjectVO>();
			var currRel:Number = initValue;//used to calculate the tables
			for (var i:uint = 0; i<xmlList.children().length(); i++){
				var obj:InputObjectVO = new InputObjectVO();
				obj.cost = Number(xmlList.children()[i].@cost);
				obj.value = currRel+Number(xmlList.children()[i].@value); //
				obj.theIndex = i;
				retVector.push(obj);
			}
			return retVector;
		}
		
		
		//returns the correct vo for the corresponding value
		private function getObjectForValue( vector:Vector.<InputObjectVO>, n:Number ):InputObjectVO {
			
			var retObj:InputObjectVO;
			for (var i:uint = 0; i<vector.length; i++){
				
				var obj:InputObjectVO = vector[i];
				if (obj.value == n){
					
					retObj = obj;
				}
			}
			return retObj;
		}
		
		private function handleServiceResult(event:Object):void{
			trace("initialise xml received");
			var xml:XML = event.result as XML;
			var vo:ReceivedDataVO = new ReceivedDataVO();
			
			//set lookup tables
			var reliabList:XMLList = xml.reliability;
			vo.reliability = returnVectorFromList( reliabList[0], Number(xml.currentReliability) );
			var nffList:XMLList = xml.nff;
			vo.nff = returnVectorFromList( nffList[0], Number(xml.currentNFF) );
			var turnList:XMLList = xml.turnaround;
			vo.turnaround = returnVectorFromList( turnList[0], Number(xml.currentTurnaround) );
			
			vo.sparesCostInc = Number(xml..sparesCost_ea);
			
			//set current
			vo.currentSpares = Number(xml.currentSpares);//used to store the current value
			
			vo.currentReliability = getObjectForValue( vo.reliability, Number(xml.currentReliability));
			vo.currentNFF = getObjectForValue( vo.nff, Number(xml.currentNFF));
			vo.currentTuranaround = getObjectForValue( vo.turnaround, Number(xml.currentTurnaround));
			
			//minimum values will be set on view components that the user is unable to go below and so are not referenced in the model
			
			userModel.vo = vo;
			userModel.budget = Number(xml.currentBudget);
			userModel.iteration = 1;
			
		}
		
		private function handleServiceFault(event:Object):void{
			trace("xml error in loading, dispatching error signal");
			var vo:ErrorVO = new ErrorVO();
			vo.title = "XML Load Error";
			vo.msg = "There has been an error loading the leader board, please click OK to attempt load again";
			vo.fn = "reloadLeaderBoard";
			errorReceived.dispatch(vo);
		}
	}
}