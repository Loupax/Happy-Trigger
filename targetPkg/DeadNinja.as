package targetPkg 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Loupax
	 */
	public class DeadNinja extends FlxSprite
	{
		[Embed(source = '../../lib/img/DeadNinja.png')]private var ImgNakedNinja:Class;
		public function DeadNinja(X:int,Y:int) 
		{
			super(X, Y, ImgNakedNinja);
			canCollide = false;
			angle = Math.random() * 90;
			acceleration.y = 300;
			scale.x = scale.y = 2;
			width = height *= scale.x;
		}
		
	}

}