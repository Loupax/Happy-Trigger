package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import FallingBottleLevel;
	import com.loupax.random.Shuffle;
	
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class NextLevelChooser extends FlxState
	{
		private var _lives:int;
		private var _difficulty:int;
		public static var musicControler:Music;
		public static var levelSequence:Array = new Array();
		[Embed(source = '../lib/snds/shmup_3.mp3')] private var bgMusic:Class;

		public static var replay:Boolean;
		public static var defaultLevel:int;
		
		public function NextLevelChooser(lives:int=3,currentDifficulty:int=1) 
		{
			_lives = lives;
			_difficulty = currentDifficulty;
					
		}
		
		override public function create():void 
		{
			if (musicControler == null) {
				musicControler = new Music(bgMusic);
			}
			if (levelSequence.length==0) {
				levelSequence = [1, 2, 3, 4, 5];
				levelSequence = Shuffle.shuffle(levelSequence);	
				levelSequence.unshift(6);
			}
			var i:int;
			
			var level:uint;
			
			if (replay == false) {
				level = levelSequence.pop();
			} else {level=defaultLevel}
			
			if (_lives <= 0) FlxG.state = new GameOverState(_difficulty) else {
			if (level == 1) FlxG.state = new FallingBottleLevel(_lives, _difficulty,0xFF00C7FF);
			if (level == 2) FlxG.state = new BlindShooting(_lives, _difficulty, 0xFF000000);
			if (level == 3) FlxG.state = new ZappingFlies(_lives, _difficulty, 0xFF000000);
			if (level == 4) FlxG.state = new ShootTheNinja(_lives, _difficulty, 0xFFF38085);
			if (level == 5) FlxG.state = new Armageddon(_lives, _difficulty, 0xff000000);
			if (level == 6) FlxG.state = new HoldYourFire(_lives, _difficulty, 0xff123456);
			}
			super.create();
		}
		
				
		override public function update():void 
		{
			super.update();
		}
		
	
		
	}

}
