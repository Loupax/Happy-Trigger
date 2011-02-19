package com.loupax.random 
{
	/**
	 * ...
	 * @author Kostas Loupasakis
	 */
	public class Shuffle
	{
		public function Shuffle():void {
			
		}
		
		public static function shuffle(arr:Array) :Array
		{
			var len:int = arr.length;
			var arr2:Array = new Array(len);
			for(var i:int = 0; i<len; i++)
			{
				arr2[i] = arr.splice(int(Math.random() * (len - i)), 1)[0];
			}
			return arr2;
		}
		
	}

}