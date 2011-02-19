package  
{
	import targetPkg.Breakable;
	import targetPkg.FlowerCore;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import targetPkg.FlowerPetal;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class LovesMe extends ShootingMinigameState
	{
		private const baseTime:Number=5;
				
		private var thisStateTime:Number;
		private var thisStateTargets:Number;
		
		public function LovesMe(lives:int,difficulty:int,bgColor:uint) 
		{
			FlxState.bgColor = bgColor;
			setDifficultyLevel(difficulty);
			super(thisStateTargets, thisStateTime, lives,difficulty);
		}
		
		override public function create():void 
		{
			
			super.create();
			FlxG.mouse.hide();
			add(new Crosshair());
			spawnFlowers();
			
			
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		private function spawnFlowers():void {
			var i:int;
			var _flowerCore:FlowerCore = new FlowerCore(Math.floor(Math.random() * (1 + FlxG.width - 60)), Math.floor(Math.random() * (1 + FlxG.height - 60)));
			spawnTarget(_flowerCore);
			for (i = 0; i < thisStateTargets; i++)
			{
								
				var _flowerPetal:FlowerPetal = new FlowerPetal(_flowerCore.x + _flowerCore.width / 2, _flowerCore.y + _flowerCore.height / 2, i * 30);
				spawnTarget(_flowerPetal);
				FlxG.showBounds = true;
				
			}
			
		}
				
		private function setDifficultyLevel(difficulty:int):void {
			thisStateTime = 100;
			thisStateTargets = 5;
		}
		
	}

}