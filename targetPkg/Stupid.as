package targetPkg 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Loupax
	 */
	public class Stupid extends FlxSprite
	{
		[Embed(source = '../../lib/img/stupid.png')] private var ImgStupid:Class;
		public function Stupid(X:int,Y:int):void 
		{
			super(X, Y);
			loadGraphic(ImgStupid, true, true, 53.6, 55);
			addAnimation("idle", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 5);
			
		}
		
		override public function update():void 
		{
			canCollide = false;
			play("idle");
			super.update();
		}
		
	}

}