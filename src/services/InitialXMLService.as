package services
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import model.UserDataModel;
	import model.vo.ErrorVO;
	import model.vo.InputObjectVO;
	import model.vo.ReceivedDataVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.http.HTTPService;
	
	import signals.ErrorReceived;
	
	import utils.DataUtils;

	public class InitialXMLService implements IXMLService
	{
		[Inject]
		public var userModel:UserDataModel;
		[Inject]
		public var errorReceived:ErrorReceived;
		private var _data:String;
		
		public function loadXML(__s:String=null):void
		{
			
			var dataFile:File = File.applicationDirectory.resolvePath(__s);
			var stream:FileStream = new FileStream();
			stream.open(dataFile, FileMode.READ);
			_data = stream.readUTFBytes(stream.bytesAvailable);
			stream.close();
			handleServiceResult(_data);
			
			/*
			var service:HTTPService = new HTTPService();
			var responder:mx.rpc.Responder = new Responder(handleServiceResult, handleServiceFault);
			var token:AsyncToken;
			service.resultFormat = "e4x";
			service.url = __s;
			token = service.send();
			token.addResponder(responder);*/
		}
		
		
		
		private function handleServiceResult(s:String):void{
			trace("initialise xml received");
			var xml:XML = new XML(s);
			var vo:ReceivedDataVO = new ReceivedDataVO();
			
			//set lookup tables
			var reliabList:XMLList = xml.reliability;
			vo.reliability = DataUtils.returnVectorFromList( reliabList[0], Number(xml.currentReliability) );
			var nffList:XMLList = xml.nff;
			vo.nff = DataUtils.returnVectorFromList( nffList[0], Number(xml.currentNFF) );
			var turnList:XMLList = xml.turnaround;
			vo.turnaround = DataUtils.returnVectorFromList( turnList[0], Number(xml.currentTurnaround) );
			
			vo.sparesCostInc = Number(xml..sparesCost_ea);
			
			//set current
			vo.currentSpares = Number(xml.currentSpares);//used to store the current value
			
			vo.currentReliability = DataUtils.getObjectForValue( vo.reliability, Number(xml.currentReliability));
			vo.currentNFF = DataUtils.getObjectForValue( vo.nff, Number(xml.currentNFF));
			vo.currentTuranaround = DataUtils.getObjectForValue( vo.turnaround, Number(xml.currentTurnaround));
			
			vo.initialData = true;
			//minimum values will be set on view components that the user is unable to go below and so are not referenced in the model
			
			userModel.iteration = 0;//incremented when the user presses go
			userModel.vo = vo;
			userModel.budget = Number(xml.currentBudget);
			
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