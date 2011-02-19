package GUI 
{
	import org.flixel.FlxSprite;
	import targetPkg.Breakable;
	/**
	 * ...
	 * @author Loupax
	 */
	public class BoundLine extends Breakable
	{
		
		public function BoundLine(X:int,Y:int,X2:int,Y2:int) 
		{
			super(X, Y);
			createGraphic(X2 - X, Y2 - Y, 0xFFffffff);
		}
		
	}

}