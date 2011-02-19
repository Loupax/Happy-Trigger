package targetPkg 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Loupax
	 */
	public class ShipDeck extends FlxSprite
	{
		[Embed(source = '../../lib/img/ShipSprDeck.png')]private var ImgDeck:Class;
		
		public function ShipDeck(X:int,Y:int) 
		{
			super(X, Y);
			loadGraphic(ImgDeck);
		}
		
		override public function update():void 
		{
			canCollide = false;
			super.update();
		}
	}

}