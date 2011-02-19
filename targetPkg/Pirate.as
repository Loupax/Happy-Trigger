package targetPkg 
{
	/**
	 * ...
	 * @author Loupax
	 */
	public class Pirate extends Breakable
	{
		[Embed(source = '../../lib/img/PirateAnimation.png')] private var PinkShirtedPiratImg:Class;
		public var isHiding:Boolean = true;
		public var jumpHeight:int = 0;
		private var initX:int;
		private var initY:int;
		
		public function Pirate(X:int,Y:int) 
		{
			initX = X;
			initY = Y;
			
			super(X, Y);
			loadGraphic(PinkShirtedPiratImg, true, false, 50, 50);
			addAnimation("idle", [0, 1, 2], 4);
			
		}
		
		override public function update():void 
		{
			play("idle");
			isHiding = checkIfIsHiding();
			jumpHeight = initY - y;
			
			if (jumpHeight <= 25) {
				isCovered = true;
			}
			
			if (jumpHeight > 25) {
				isCovered = false;
			}
			
			super.update();
			
		}
		
		public function hide(speed:int):void {
			if (jumpHeight > 0) {
				y += speed;
			}
			
		}
		public function unhide(speed:int):void {
			if (jumpHeight < 50) {
				y -= speed;
			}
			
		}
		
		private function checkIfIsHiding():Boolean {
			if (x == initX && y == initY) return true else return false;
		}
	}

}