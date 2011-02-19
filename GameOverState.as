package  
{
	import org.flixel.FlxButton;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import flash.ui.Mouse;
	import flash.net.LocalConnection;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class GameOverState extends FlxState
	{
		private var GameSpr:FlxSprite;
		private var OverSpr:FlxSprite;
		private var BackGroundSpr:FlxSprite;
		private var ReplayBtn:FlxButton;
		private var ReplaySpr:FlxSprite;
		
		private var highScoreEver:FlxText;
		private var highScoreTxt:FlxText;
		private var _highScore:int;
		private var savedGame:FlxSave;
		
		[Embed(source = '../lib/img/GameOverScreenBg.png')] private var ImgBg:Class;
		[Embed(source = '../lib/img/GameWordSpritesheet.png')]private var GameWordSpritesheet:Class;
		[Embed(source = '../lib/img/OverWordSpritesheet.png')]private var ImgOver:Class;
		[Embed(source = '../lib/img/ReplayBtn.png')]private var ImgReplayBtn:Class;
		
		
		public function GameOverState(highScore:int) 
		{
			FlxG.mouse.show();
			_highScore = highScore-1;
			
			BackGroundSpr = new FlxSprite(0, 0, ImgBg);
			add(BackGroundSpr);
			
			GameSpr = new FlxSprite(50, 0);
			GameSpr.loadGraphic(GameWordSpritesheet, true, false, 560, 180, true);
			GameSpr.addAnimation("idle", [0, 1, 2], 8, true);
			add(GameSpr);
			
			OverSpr = new FlxSprite(FlxG.width/8, GameSpr.height + 50);
			OverSpr.loadGraphic(ImgOver, true, false, 409, 129);
			GameSpr.addAnimation("idle", [0]);
			add(OverSpr);
			
			ReplayBtn = new FlxButton((FlxG.width/2)-50,FlxG.height-100, replayGame);
			ReplaySpr = new FlxSprite(0, 0, ImgReplayBtn);
			ReplayBtn.loadGraphic(ReplaySpr);
			add(ReplayBtn);
			
		}
		
		override public function create():void 
		{
			
			savedGame = new FlxSave();
			savedGame.bind("happyTriggerSave");
			saveThisScore(ShootingMinigameState.globalScore, "highScore");
			saveThisScore(FallingBottleLevel.bottlesScore, "bottlesScore");
			saveThisScore(BlindShooting.blindShootingScore, "blindShootingScore");
			saveThisScore(ShootTheNinja.ninjaScore, "shootingNinjasScore");
			saveThisScore(Armageddon.armageddonScore, "armageddonScore");
			saveThisScore(ZappingFlies.fliesScore, "zappingFliesScore");
			
			trace("Bullets fired:" + ShootingMinigameState.bulletsFired + " Bullets hit:" + ShootingMinigameState.bulletsHit);
			trace("Accuracy: " + (ShootingMinigameState.bulletsHit/ShootingMinigameState.bulletsFired) * 100 + "%");
			trace("Falling bottles score:" + getThisScore("bottlesScore"));
			trace("Blind shooting score:" + getThisScore("blindShootingScore"));
			trace("Shooting Ninjas Score" + getThisScore("shootingNinjasScore"));
			trace ("Armageddon score:" + getThisScore("armageddonScore"));
			trace("Zapping Flies Score:" + getThisScore("zappingFliesScore"));
			
			highScoreEver = new FlxText(150, (FlxG.height / 2) -50, 400, "High Score: " + savedGame.read("highScore")+"!");
			highScoreEver.size = 40;
			highScoreEver.color = 0;
			add(highScoreEver);
			
			
			highScoreTxt = new FlxText(180, (FlxG.height/2)-80, 400, "Stages beat: "+ShootingMinigameState.globalScore.toString());
			highScoreTxt.size = 30;
			highScoreTxt.color = 0;
			add(highScoreTxt);
			
			FlxG.mouse.hide();
						
			resetScores();
						
			super.create();
			
			
		}
		
		private function resetScores():void {
			ShootingMinigameState.globalScore = 0;
			FallingBottleLevel.bottlesScore = 0;
			BlindShooting.blindShootingScore = 0;
			ShootTheNinja.ninjaScore = 0;
			Armageddon.armageddonScore = 0;
			ZappingFlies.fliesScore = 0;
		}
		
		
		
		private function getThisScore(scoreSave:String):int {
			return savedGame.read(scoreSave) as int;
		}
		
		private function onConnectError():void {
			
		}
		
		private function saveThisScore(score:int, scoreSave:String):void {
			if (savedGame.read(scoreSave) == null || savedGame.read(scoreSave) < score) {
				savedGame.write(scoreSave, score);
				savedGame.forceSave();
			}
		}
		
		private function replayGame():void {
			FlxG.music.destroy();
			FlxG.state = new MainMenuState();
		}
		
				
		override public function update():void 
		{			
			Mouse.show();
			GameSpr.play("idle");
			OverSpr.play("idle");
			super.update();
		}
		
	}

}