package targetPkg 
{
	import flash.text.engine.BreakOpportunity;
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class ForbiddenTarget extends Breakable
	{
		
		public function ForbiddenTarget(X:int,Y:int) 
		{
			super(X, Y);
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}

}