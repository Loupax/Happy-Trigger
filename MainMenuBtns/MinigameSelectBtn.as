package MainMenuBtns 
{
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class MinigameSelectBtn extends FlxButton
	{
		public var thisBtnSpr:FlxSprite;
		
		private var initX:int;
		private var initY:int;
		private var initAngle:int;
		
		public function MinigameSelectBtn(X:int,Y:int,Callback:Function,Graphic:Class,animationWidth:Number=0,animationHeight:Number=0) 
		{
			super(X, Y, Callback);
			initX = X;
			initY = Y;
			initAngle = angle;
			thisBtnSpr = new FlxSprite(0, 0);
			thisBtnSpr.loadGraphic(Graphic, true,false,animationWidth,animationHeight);
			thisBtnSpr.addAnimation("still", [0]);
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
			
			thisBtnSpr.play("still");
			super.update();
		}
		
	}

}