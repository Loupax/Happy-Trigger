package MainMenuBtns 
{
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class MenuBtn extends FlxButton
	{
		private var initX:int;
		private var initY:int;
		private var initAngle:int;
		
		private var thisBtnSpr:FlxSprite;
		public function MenuBtn(X:int,Y:int,Graphic:Class,Callback:Function) 
		{
			super(X, Y, Callback);
			initX = X;
			initY = Y;
			initAngle = angle;
			thisBtnSpr = new FlxSprite(0, 0, Graphic);
			loadGraphic(thisBtnSpr);
		}
		
		override public function update():void 
		{
			width = thisBtnSpr.width;
			height = thisBtnSpr.height;
			var choice:int = Math.floor(Math.random() * 9);
			if (choice == 0) thisBtnSpr.angle += 1;
			if (choice == 1) thisBtnSpr.angle -= 1;
			if (choice == 2) thisBtnSpr.x -= 1;
			if (choice == 3) thisBtnSpr.x += 1;
			if (choice == 4) thisBtnSpr.x = initX;
			if (choice == 5) thisBtnSpr.y = initY;
			if (choice == 6) thisBtnSpr.angle = initAngle;
			if (choice == 7) thisBtnSpr.y -= 1;
			if (choice == 8) thisBtnSpr.y += 1;
			super.update();
		}
		
	}

}