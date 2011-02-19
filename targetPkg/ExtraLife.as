package targetPkg 
{
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	import org.flixel.FlxG;
	public class ExtraLife extends Breakable
	{
		[Embed(source = '../../lib/img/heart.png')]private var ImgExtraLife:Class;
		
		public function ExtraLife(X:int,Y:int) 
		{
			super(X, Y);
			loadGraphic(ImgExtraLife);
		}
		
		override public function update():void 
		{
			scale.x = scale.y = 0.5;
			width = height *= 0.5;
			velocity.x = -300;
			canCollide = false;
			velocity.y = Math.sin(x/50)*150;
			trace("X: " + x + "Y:" + y);
			super.update();
		}
		
	}

}