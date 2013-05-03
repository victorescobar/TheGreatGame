package 
{
 import com.coreyoneil.collision.CollisionGroups;
 import com.coreyoneil.collision.CDK;
 import flash.display.Sprite;
 import flash.display.DisplayObject;
 import flash.display.Stage;
 import flash.events.Event;


	public class GroupCollider extends Sprite
	{
	 public var collisionGroup = new CollisionGroups();
	 private var collisionGroupHistory:Array = [];

		public function GroupCollider()
		{
		 init();
		}

		private function init(e:Event=null):void
		{
		 addEventListener(Event.ENTER_FRAME, check_collisions, false, 0, true);
		 addEventListener(Event.REMOVED_FROM_STAGE, clean, false, 0, true);
		}

		private function clean(e:Event):void
		{
		 removeEventListener(Event.ENTER_FRAME, check_collisions);
		}
		
		public function add_object(obj:Object, group:String):void
		{
		 	if ( obj is Array )
			{
				for each (var dispObj:DisplayObject in obj)
				 collisionGroup.addGroupItem(dispObj, group);
			} else {
			 collisionGroup.addGroupItem(obj, group);
			}
		}
		
		public function remove_object(obj:Object, group:String):void
		{
			if ( obj is Array )
			{
				for each (var dispObj:DisplayObject in obj)
				 collisionGroup.removeGroupItem(dispObj, group);
			} else {
			 collisionGroup.removeGroupItem(obj, group);
			}
		}
		
		public function check_collisions(e:Event=null):void
		{
		 var allCollisions:Array = collisionGroup.checkCollisions();
		 var history:Array = collisionGroupHistory;
		 var currentCollisions:Array = [];

			if (allCollisions.length)
			{
				for each (var collision:Object in allCollisions)
				{
				 var collisionPair:Array = [collision.object1, collision.object2];
				 
				 currentCollisions.push(collisionPair);
					
					if (! collision_in_set(collisionPair, history))
					{
					 history.push(collisionPair);
					 collision.object1.collide(collision.object2);
					 collision.object2.collide(collision.object1);
					}
				}
			}
			
			for each (var oldCollision:Array in history)
			{
				if (! collision_in_set(oldCollision, currentCollisions))
				{
				 oldCollision[0].un_collide(oldCollision[1]);
				 oldCollision[1].un_collide(oldCollision[0]);
				 history.splice(history.indexOf(oldCollision), 1);
				}
			}
			
		}
		
		private function collision_in_set(testCollision:Array, collisionSet:Array)
		{
			for each (var collision:Array in collisionSet)
			{
				if (compare_collision_set(collision, testCollision))
				{
				 return true;
				}
			}
		 return false;
		}
		
		private function compare_collision_set(collision1:Array, collision2:Array)
		{
		 return collision1[0] == collision2[0] && collision1[1] == collision2[1];
		}
	}
}