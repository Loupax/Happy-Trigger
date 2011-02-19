package targetPkg 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Loupax
	 */
	public class ObstacleGraphic extends FlxSprite
	{
		
		
		public function ObstacleGraphic(X:int,Y:int) 
		{
			super(X,Y)
		}
		
		override public function update():void 
		{
			canCollide = false;
			super.update();
		}
		
		public function respawn(X:int, Y:int):void {
			x = X;
			y = Y;
		}
		
	}

}