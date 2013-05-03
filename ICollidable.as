package
{
 import flash.display.DisplayObject;
	
	public interface ICollidable
	{
	 function collide(obj:DisplayObject):void;
	 function un_collide(obj:DisplayObject):void;
	}
}
