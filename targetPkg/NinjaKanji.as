package targetPkg 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Loupax
	 */
	public class NinjaKanji extends FlxSprite
	{
		[Embed(source = '../../lib/img/ninja_kanji.png')]private var NinjaImg:Class;
		public function NinjaKanji(X:int,Y:int) 
		{
			super(X, Y,NinjaImg);
		}
		
		override public function update():void 
		{
			canCollide = false;
			super.update();
		}
		
	}

}