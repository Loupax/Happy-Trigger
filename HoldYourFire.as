package  
{

	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class HoldYourFire extends ShootingMinigameState
	{
		[Embed(source = '../lib/snds/tick.mp3')]private var tickTockSnd:Class;
		
		public function HoldYourFire(lives:int,difficulty:int,bgColor:uint) 
		{
			FlxState.bgColor = bgColor;
			setDifficultyLevel(difficulty);
			super(0, thisStateTime, lives,difficulty);
		}
		
		override public function create():void 
		{
			super.create();
			var waitPhrases:Array = new Array();
			waitPhrases.push("Break time!");
			waitPhrases.push("So... Doing anything later?");
			waitPhrases.push("Nice weather isn't it?");
			waitPhrases.push("This is only a subliminal message. Please ignore it.");
			waitPhrases.push("You didn't think it was going to be that easy, did you?");
			waitPhrases.push("I'm your mouse. Please be gentle...");
			waitPhrases.push("Yes. You are the Game God!");
			waitPhrases.push("Don't pet a dog that's on fire!");
			waitPhrases.push("HOLD YOUR FIRE!!!!");
			waitPhrases.push("You know, shooting the ninja while he touches the bush, only wastes bullets...");
			waitPhrases.push("Yes. Shooting asteroids is more efficient than nuking them from the inside.");
			waitPhrases.push("Make sure you take care of your wrist!");
			
			var currentPhrase:String = new String(waitPhrases[Math.floor(Math.random() * waitPhrases.length)]);
			var textLenght:int = currentPhrase.length;
			if (textLenght > 20) textLenght = 20; 
			
			FlxG.play(tickTockSnd);
			FlxG.music.fadeOut(0.5, true);
			var labelTxt:FlxText = new FlxText(FlxG.width / 2 - ((textLenght*20) / 2), FlxG.height / 2, textLenght*20 , currentPhrase);
			labelTxt.size = 20;
			add(labelTxt);
		}
		
		private function setDifficultyLevel(difficulty:int):void {
			thisStateTime = 5;
		}
		
		override protected function winLevel():void 
		{
			currentDifficultyLevel += 3;
			FlxG.music.fadeIn(0.5);
			super.winLevel();
		}
		
	}

}