package view.components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class CoinSprite extends Sprite
	{
		[Embed(source="../embed/coin.png")]
		private var CoinBmp:Class;
		
		private var holder:Sprite;
		
		public function CoinSprite()
		{
			initDisplay();
		}
		
		private function initDisplay():void{
			
			holder = new Sprite();
			
			var bmp:Bitmap = new CoinBmp();
			var bitmap:Bitmap = new Bitmap(bmp.bitmapData);
			
			holder.graphics.beginFill(Math.random()*0xffffff);
			holder.graphics.drawRect(0, 0,147, 120);
			//addChild(holder);
			bitmap.x = 0-(bitmap.width*.5);
			bitmap.smoothing = true;
			addChild(bitmap);
			
		}
	}
}