package targetPkg 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Loupax
	 */
	public class ShipBW extends FlxSprite
	{
		[Embed(source = '../../lib/img/ShipBW.png')]private var ImgShipBG:Class;
		public function ShipBW(X:int,Y:int) 
		{
			super(X, Y);
			loadGraphic(ImgShipBG);
		}
		
		override public function update():void 
		{
			canCollide = false;
			super.update();
		}
		
	}

}