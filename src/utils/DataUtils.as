package utils
{
	import model.vo.InputObjectVO;
	import model.vo.InputVO;

	public class DataUtils
	{
		public function DataUtils()
		{
		}
		
		public static function returnVectorFromList( xmlList:XML, initValue:Number ):Vector.<InputObjectVO>{
			
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
		
		public static function getVectorFromStartingVO( vect:Vector.<InputObjectVO>, vo:InputObjectVO):Vector.<InputObjectVO>{
			
			var retVect:Vector.<InputObjectVO>; 
			var startInd:int = vect.indexOf(vo);
			retVect = vect.slice(startInd, vect.length);
			return retVect;
			
			
		}
		
		public static function convertArrayToVector( a:Array ):Vector.<Number>{
			
			var retV:Vector.<Number> = new Vector.<Number>();
			
			for(var i:uint = 0; i<a.length; i++){
				retV.push(a[i]);
			}
			return retV;
		}
		
		//returns the correct vo for the corresponding value --todo nice - should be abstracted to a utils class
		public static function getObjectForValue( vector:Vector.<InputObjectVO>, n:Number ):InputObjectVO {
			
			var retObj:InputObjectVO;
			for (var i:uint = 0; i<vector.length; i++){
				
				var obj:InputObjectVO = vector[i];
				if (obj.value == n){
					
					retObj = obj;
				}
			}
			return retObj;
		}
		
	}
}