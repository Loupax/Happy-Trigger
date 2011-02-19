package targetPkg 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Loupax
	 */
	public class Obstacle extends FlxSprite
	{
		
		
		public function Obstacle(X:int,Y:int) 
		{
			canCollide = false;
			super(X, Y);
			createGraphic(2, 2, 0xFF55F23B);
			//width = height = 100;
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		public function respawn(X:int,Y:int):void {
			x = X;
			y = Y;
			
		}
		
	}

}