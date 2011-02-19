package targetPkg 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class DeadFly extends FlxSprite
	{
		[Embed(source = '../../lib/img/deadFly.png')] private var ImgDeadFly:Class;
		[Embed(source = '../../lib/snds/squish1.mp3')] private var squishSnd:Class;
		public function DeadFly(X:int,Y:int) 
		{
			super(X, Y, ImgDeadFly);
			width = height *= 0.3;
			scale.x = scale.y = 0.3;
			velocity.y = 300;
			canCollide = false;
			FlxG.play(squishSnd);
		}
		
	}

}