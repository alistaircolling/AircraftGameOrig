package model
{
	import org.robotlegs.mvcs.Actor;
	
	public class LookupTablesModel extends Actor
	{
		
		public var sparesInc:Number;
		public var reliability:Vector.<Number>;
		public var turnaround:Vector.<Number>;
		public var nff:Vector.<Number>;
		
		public var currentSpares:uint;
		public var currentReliability:uint;
		public var currentTuranaround:uint;
		public var currentNFF:uint;
		
		public var budget:Number;
		
	}
}