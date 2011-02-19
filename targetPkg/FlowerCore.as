package targetPkg 
{
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class FlowerCore extends Breakable
	{
		[Embed(source = '../../lib/img/flowerCore.png')] private var ImgFlowerCore:Class
		
		public function FlowerCore(X:int, Y:int) 
		{
			super(X, Y);
			loadGraphic(ImgFlowerCore);
			addAnimation("idle", [0], 0);
			health = 1;
			isForbiddenTarget = true;
			
		}
		override public function update():void 
		{
			play("idle");
			super.update();
		}
		
	}

}