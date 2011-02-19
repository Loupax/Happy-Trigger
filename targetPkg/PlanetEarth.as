package targetPkg 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Loupax
	 */
	public class PlanetEarth extends FlxSprite
	{
		[Embed(source = '../../lib/img/EarthAnim.png')] private var ImgEarth:Class;
		
		public function PlanetEarth(X:int,Y:int) 
		{
			super(X, Y);
			scale.x = scale.y = 2;
			height = width *= scale.x;
			loadGraphic(ImgEarth,true);
			addAnimation("idle", [0, 1, 2], 6);
		}
		
		override public function update():void 
		{
			play("idle");
			canCollide = false;
			super.update();
		}
		
	}

}