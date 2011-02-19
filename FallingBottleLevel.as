package  
{
	import flash.external.ExternalInterface;
	import net.pixelpracht.tmx.TmxMap;
	import net.pixelpracht.tmx.TmxObject;
	import net.pixelpracht.tmx.TmxObjectGroup;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxText;
	
	import targetPkg.Bottle
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class FallingBottleLevel extends ShootingMinigameState 
	{
		public static var bottlesScore:int;
		private const baseTime:Number=5;
		private const initInterval:Number=0.2;
		private var bottleSpawnInterval:Number = initInterval;
		
		private var bottle:Bottle;
		
		//private var thisStateTime:Number;
		private var thisStateTargets:Number;
		
		
		
		public function FallingBottleLevel(lives:int,difficulty:int,bgColor:uint):void {
			FlxState.bgColor = bgColor;
			setDifficultyLevel(difficulty);
			super(thisStateTargets, thisStateTime, lives,difficulty);
		
		}
		
				
		override public function create():void 
		{
			super.create();
			FlxG.mouse.hide();
			add(new Crosshair());
			
			instructions.x = Math.random() * FlxG.width;
			instructions.y = FlxG.height - 25;
			instructions.visible = true;
			instructions.color = 0xff000000;
			instructions.text = "Infinite bottles of beer on the wall, infinite bottles of beer. Blast one down, shoot it around, infinite bottles of beer on the wall!!";
		}
		
		override public function update():void 
		{
			if (spawnIntervalPassed()) {
				spawnTarget(new Bottle(Math.round(Math.random()*FlxG.width),-10));
			}
			super.update();
		}
		
				
		private function spawnIntervalPassed():Boolean {
			if (bottleSpawnInterval < 0) {
				bottleSpawnInterval = initInterval;
				return true;
			} else {
				bottleSpawnInterval -= FlxG.elapsed;
				return false;
			}
		}
		
		override protected function winLevel():void 
		{
			bottlesScore++;
			super.winLevel();
		}
		
		private function setDifficultyLevel(difficulty:int):void {
			if (difficulty == 1) thisStateTime = baseTime;
			if (difficulty == 2) thisStateTime = baseTime-0.2;
			if (difficulty == 3) thisStateTime = baseTime-0.4;
			if (difficulty == 4) thisStateTime = baseTime-0.6;
			if (difficulty == 5) thisStateTime = baseTime-0.8;
			if (difficulty == 6) thisStateTime = baseTime-1;
			if (difficulty >= 7) thisStateTime = baseTime-1;
			
			if (difficulty < 6) thisStateTargets =  1+difficulty else thisStateTargets = 7;
		}
		
		
	}

}