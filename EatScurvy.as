package  
{
	import com.loupax.random.Shuffle;
	import flash.desktop.ClipboardTransferMode;
	import flash.text.engine.TypographicCase;
	import org.flixel.FlxGroup;
	import targetPkg.Breakable;
	import targetPkg.Pirate;
	import org.flixel.FlxState;
	import targetPkg.ShipBW;
	import targetPkg.ShipDeck;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Loupax
	 */
	public class EatScurvy extends ShootingMinigameState
	{
		private var howManyPirates:int;
		private var thisStateTime:Number;
		private var _pirate:Pirate;		
		private var shipBW:ShipBW;
		private var shipDeck:ShipDeck;
		private var jumpInterval:Number = 0.5;
		private var jumpDuration:Number = 1;
		private var duckDuration:Number = jumpDuration;
		private var choiceInterval:Number = jumpInterval + jumpDuration * 2;
		private var spawnPoints:Array = [[102, 345], [162, 355], [236, 378], [300, 400], [364, 362], [431, 345]];
		private var pirateSequence:Array = [0, 1, 2, 3, 4, 5];
		private var currentPirate:int=0;
		private var currentPirateIsUp:Boolean = false;
		
		public function EatScurvy(lives:int,difficulty:int,bgColor:uint) 
		{
			FlxState.bgColor = bgColor;
			setDifficultyLevel(difficulty);
			super(howManyPirates, thisStateTime, lives,difficulty);
		}
		
		override public function create():void 
		{
			super.create();
			shipBW = new ShipBW(150, 90);
			add(shipBW);
			
			targets = new FlxGroup();
			add(targets);
			
			var i:int;
			for (i = 0; i < spawnPoints.length; i++)
			{
				spawnTarget(new Pirate(spawnPoints[i][0],spawnPoints[i][1]));
			}
			
			shipDeck = new ShipDeck(shipBW.x, shipBW.y);
			add(shipDeck);
			
			shipBW.scale.x = shipBW.scale.y = shipDeck.scale.x = shipDeck.scale.y = 1.5;
			shipBW.height = shipBW.width = shipDeck.height = shipDeck.width *= 1.5;
			pirateSequence=Shuffle.shuffle(pirateSequence);
			
		}
		
		override public function update():void 
		{
			if (FlxG.keys.R) FlxG.state = new NextLevelChooser(5, 1);
			
			//if (FlxG.keys.SPACE) targets.members[0].unhide(5);
			//if (FlxG.keys.C) targets.members[0].hide(5);
			
			if (choiceInterval > 0) choiceInterval -= FlxG.elapsed;
			if (choiceInterval < 0) { currentPirate++; choiceInterval = jumpInterval + jumpDuration * 2; }
			
			if (jumpDuration > 0) { pirateGoUp(targets.members[pirateSequence[currentPirate]]); jumpDuration -= FlxG.elapsed;}
			if (jumpDuration < 0) { currentPirateIsUp=true;	jumpDuration = 1; }
			
			if(currentPirateIsUp==true){
			if (duckDuration > 0) { pirateGoDown(targets.members[pirateSequence[currentPirate]]); duckDuration -= FlxG.elapsed; }
			if (duckDuration < 0) { duckDuration = 1; currentPirateIsUp = false; }
			}
			shipBW.x = shipDeck.x;
			shipBW.y = shipDeck.y;
			if (currentPirate >pirateSequence.length-1) pirateSequence=Shuffle.shuffle(pirateSequence);
			super.update();
			
		}
		
		private function pickAPirate():int {
			var pirate:int = Math.floor(Math.random() * 6);
			trace("Pirate picked:"+pirate);
			return pirate;
		}
		
		private function pirateGoUp(_pirate:Pirate):void {
			if(jumpDuration>0)
			{
				trace(currentPirate);
				_pirate.unhide(2);
				jumpDuration -= FlxG.elapsed;
			}
			if (jumpDuration < 0)
			{
				jumpDuration = 1;
			}
	
		}
		
		private function pirateGoDown(_pirate:Pirate):void {
			if(jumpDuration>0)
			{
				_pirate.hide(2);
				duckDuration -= FlxG.elapsed;
			}
			if (jumpDuration < 0)
			{
				duckDuration = 1;
			}
		}
		
		
		private function setDifficultyLevel(diff:int):void {
			howManyPirates = 1;
			thisStateTime = 100;
		}
		
		private function aPirateIsUp():Boolean {
			var i:int;
			for (i = 0; i < targets.members.length; i++)
				if (targets.members[i].jumpHeight>45) return true;
			
			return false;
		}
		
	}

}