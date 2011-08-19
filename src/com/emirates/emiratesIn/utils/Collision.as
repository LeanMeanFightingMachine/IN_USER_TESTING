package com.emirates.emiratesIn.utils
{
	import flash.display.Bitmap;
	import com.emirates.emiratesIn.display.ui.debug.Debug;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * @author fraserhobbs
	 */
	public class Collision
	{
		private static var _lookup:Dictionary = new Dictionary();
		
		public static function detect(parent:DisplayObjectContainer, a:DisplayObject, b:DisplayObject, aReset:Boolean = false, bReset:Boolean = false):Boolean
		{
			if(a.hitTestObject(b))
			{
				var aHit : HitObject = Collision.getBitmapData(parent, a, aReset);
				var bHit : HitObject = Collision.getBitmapData(parent, b, bReset);

				var bbm : Bitmap = new Bitmap(bHit.bitmapData);
				var abm : Bitmap = new Bitmap(aHit.bitmapData);
				
				//parent.addChild(bbm);
				//parent.addChild(abm);

				bbm.x = b.x - bHit.offsetX;
				bbm.y = b.y - bHit.offsetY;

				abm.x = a.x - aHit.offsetX;
				abm.y = a.y - aHit.offsetY;
				
				Debug.log("object hit");

				if (aHit.bitmapData.hitTest(new Point(a.x - aHit.offsetX, a.y - aHit.offsetY), 255, bHit.bitmapData, new Point(b.x - bHit.offsetX, b.y - bHit.offsetY), 255))
				{
					Debug.log("bitmap hit");
					return true;
				}
			}
			
			return false;
		}
		
		private static function getBitmapData(parent:DisplayObjectContainer, obj:DisplayObject, reset:Boolean):HitObject
		{
			var classRef:Class = obj["constructor"] as Class;

			var hitObject:HitObject = _lookup[classRef];
	
			if(!hitObject || reset)
			{
				var rect:Rectangle = obj.getBounds(parent);
				
				var offset:Matrix = obj.transform.matrix;
				offset.tx = obj.x - rect.x;
				offset.ty = obj.y - rect.y;
				
				//Debug.log("x " + classRef + " : " + offset.tx);
				//Debug.log("y " + classRef + " : " + offset.ty);
				
				var bitmapData:BitmapData = new BitmapData(rect.width, rect.height, true, 0);
				bitmapData.draw(obj, offset);
				hitObject = new HitObject(bitmapData, offset.tx, offset.ty);
				_lookup[classRef] = hitObject;
			}

			return hitObject;
		}
	}
}
import flash.display.BitmapData;

class HitObject
{
	public var bitmapData:BitmapData;
	public var offsetX:Number;
	public var offsetY:Number;
	
	public function HitObject(bitmapData:BitmapData, offsetX:Number, offsetY:Number)
	{
		this.bitmapData = bitmapData;
		this.offsetX = offsetX;
		this.offsetY = offsetY;
	}
}
