/*******************************************************************************
 * Copyright (c) 2010 by Thomas Jahn
 * Questions or license requests? Mail me at lithander@gmx.de!
 ******************************************************************************/
package net.pixelpracht.geometry 
{
	/**
	 * Provides some Angle related helper methods
	 */
	public class Angle
	{
		public function Angle()
		{
			
		}
		
		public static const TwoPI:Number = Math.PI*2;
		
		public static function normalizeRad(angle:Number):Number
		{
			while( angle < -Math.PI)
				angle += TwoPI;
			while( angle > Math.PI)
				angle -= TwoPI;
			return angle;
		}		
		
		public static function normalizeDeg(angle:Number):Number
		{
			while( angle < -180)
				angle += 360;
			while( angle > 180)
				angle -= 360;
			return angle;
		}
		
		/**
		 * These companion methods will convert radians to degrees
		 * and degrees to radians.
		 */		
		public static function radToDeg(radians:Number):Number
		{
			return radians * 180 / Math.PI;
		}
		
		public static function degToRad(degrees:Number):Number
		{
			return degrees * Math.PI / 180;
		}	
		
		public static function coneAngle(v:Vector2D, v2:Vector2D):Number
		{
			return Math.atan2(v.y,v.x) - Math.atan2(v2.y,v2.x);
		}
		
		public static function polarAngle(v:Vector2D):Number
		{
			return Math.atan2(v.y, v.x);
		}

	}
}