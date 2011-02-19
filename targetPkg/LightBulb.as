package targetPkg 
{
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class LightBulb extends Breakable
	{
		[Embed(source = '../../lib/img/pixelatedLightbulb.png')] private var ImgBulb:Class;
		public function LightBulb(X:int,Y:int) 
		{
			super(X, Y);
			loadGraphic(ImgBulb);
			addAnimation("idle", [0]);
		}
		
		override public function update():void 
		{
			play("idle");
			
						
			super.update();
		}
		
	}

}